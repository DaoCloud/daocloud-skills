$ErrorActionPreference = 'Stop'

if (-not $env:DCE_HOST) { throw 'DCE_HOST is required' }
if (-not $env:DCE_TOKEN) { throw 'DCE_TOKEN is required' }

$cluster = 'kpanda-global-cluster'
$namespace = 'default'
$pendingPod = 'k8s-ai-bench-diag-pending-pod'
$cfgPod = 'k8s-ai-bench-diag-cfg-pod'

$dceToken = $env:DCE_TOKEN
if ($dceToken.StartsWith('Bearer ')) {
    $dceToken = $dceToken.Substring(7)
}

$workDir = New-Item -ItemType Directory -Path (Join-Path ([System.IO.Path]::GetTempPath()) ("cluster-diagnosis-setup-" + [System.IO.Path]::GetRandomFileName())) -Force
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
try {
    $dceToken | & dce --insecure --hostname $env:DCE_HOST auth login `
        --auth-type bearer --with-token --skip-validate | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "DCE authentication failed with exit code $LASTEXITCODE"
    }

    # Idempotency: remove any leftover fixtures from a previous aborted run.
    foreach ($podName in @($pendingPod, $cfgPod)) {
        & dce --insecure --hostname $env:DCE_HOST container-management core delete-pod `
            --cluster $cluster --namespace $namespace --name $podName -o json | Out-Null
    }

    # Fixture 1: unschedulable Pod — an impossible resource request keeps it
    # Pending forever, without depending on image pulls or node capacity.
    $pendingJson = @"
{
  "apiVersion": "v1",
  "kind": "Pod",
  "metadata": {
    "name": "$pendingPod",
    "namespace": "$namespace"
  },
  "spec": {
    "containers": [
      {
        "name": "main",
        "image": "nginx:stable",
        "resources": {
          "requests": {
            "cpu": "100",
            "memory": "200Gi"
          }
        }
      }
    ]
  }
}
"@

    # Fixture 2: a container referencing a missing ConfigMap key fails before
    # the image is pulled, with a deterministic CreateContainerConfigError.
    $cfgJson = @"
{
  "apiVersion": "v1",
  "kind": "Pod",
  "metadata": {
    "name": "$cfgPod",
    "namespace": "$namespace"
  },
  "spec": {
    "containers": [
      {
        "name": "main",
        "image": "nginx:stable",
        "env": [
          {
            "name": "MISSING",
            "valueFrom": {
              "configMapKeyRef": {
                "name": "k8s-ai-bench-nonexistent-config",
                "key": "value"
              }
            }
          }
        ]
      }
    ]
  }
}
"@

    foreach ($fixture in @(@{ Json = $pendingJson; File = 'pending-body.json' }, @{ Json = $cfgJson; File = 'cfg-body.json' })) {
        $bodyJson = [pscustomobject]@{ data = $fixture.Json } | ConvertTo-Json -Compress
        $bodyPath = Join-Path $workDir $fixture.File
        [System.IO.File]::WriteAllText($bodyPath, $bodyJson, $utf8NoBom)
        & dce --insecure --hostname $env:DCE_HOST container-management apps create-workload-by-json `
            --cluster $cluster --namespace $namespace --kind pods --file $bodyPath | Out-Null
        if ($LASTEXITCODE -ne 0) {
            throw "Fixture Pod creation failed with exit code $LASTEXITCODE"
        }
    }

    $deadline = (Get-Date).AddSeconds(180)
    while ($true) {
        $pendingPhase = $null
        $cfgReason = $null

        $pendingResponse = & dce --insecure --hostname $env:DCE_HOST container-management core get-pod `
            --cluster $cluster --namespace $namespace --name $pendingPod -o json
        if ($LASTEXITCODE -eq 0 -and $pendingResponse) {
            try {
                $pendingPhase = (($pendingResponse -join "`n") | ConvertFrom-Json).status.phase
            } catch {
            }
        }

        $cfgResponse = & dce --insecure --hostname $env:DCE_HOST container-management core get-pod `
            --cluster $cluster --namespace $namespace --name $cfgPod -o json
        if ($LASTEXITCODE -eq 0 -and $cfgResponse) {
            try {
                $cfgPodObj = ($cfgResponse -join "`n") | ConvertFrom-Json
                foreach ($state in @($cfgPodObj.status.containerStatuses)) {
                    if ($state.state.waiting.reason) {
                        $cfgReason = $state.state.waiting.reason
                        break
                    }
                }
            } catch {
            }
        }

        if ($pendingPhase -eq 'Pending' -and $cfgReason -eq 'CreateContainerConfigError') {
            Write-Host "Fixture pods ready: $pendingPod Pending, $cfgPod CreateContainerConfigError."
            exit 0
        }
        if ((Get-Date) -ge $deadline) {
            throw "Fixtures not ready within 180s (pending phase: $pendingPhase, cfg reason: $cfgReason)"
        }
        Start-Sleep -Seconds 5
    }
}
finally {
    Remove-Item -LiteralPath $workDir -Force -Recurse -ErrorAction SilentlyContinue
}
