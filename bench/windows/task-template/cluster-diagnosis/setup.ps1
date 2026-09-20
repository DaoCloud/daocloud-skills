$ErrorActionPreference = 'Stop'

if (-not $env:DCE_HOST) { throw 'DCE_HOST is required' }
if (-not $env:DCE_TOKEN) { throw 'DCE_TOKEN is required' }

$cluster = 'kpanda-global-cluster'
$namespace = 'default'
$pendingPod = 'k8s-ai-bench-diag-pending-pod'
$pvcPod = 'k8s-ai-bench-diag-pvc-pod'

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
    foreach ($podName in @($pendingPod, $pvcPod)) {
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

    # Fixture 2: a Pod referencing a missing PersistentVolumeClaim is held
    # Pending by the scheduler with an unbound-volume failure. Like fixture 1
    # it is never scheduled, so no image pull is ever attempted.
    $pvcJson = @"
{
  "apiVersion": "v1",
  "kind": "Pod",
  "metadata": {
    "name": "$pvcPod",
    "namespace": "$namespace"
  },
  "spec": {
    "containers": [
      {
        "name": "main",
        "image": "nginx:stable"
      }
    ],
    "volumes": [
      {
        "name": "data",
        "persistentVolumeClaim": {
          "claimName": "k8s-ai-bench-nonexistent-pvc"
        }
      }
    ]
  }
}
"@

    foreach ($fixture in @(@{ Json = $pendingJson; File = 'pending-body.json' }, @{ Json = $pvcJson; File = 'pvc-body.json' })) {
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
        $pvcPhase = $null

        $pendingResponse = & dce --insecure --hostname $env:DCE_HOST container-management core get-pod `
            --cluster $cluster --namespace $namespace --name $pendingPod -o json
        if ($LASTEXITCODE -eq 0 -and $pendingResponse) {
            try {
                $pendingPhase = (($pendingResponse -join "`n") | ConvertFrom-Json).status.phase
            } catch {
            }
        }

        $pvcResponse = & dce --insecure --hostname $env:DCE_HOST container-management core get-pod `
            --cluster $cluster --namespace $namespace --name $pvcPod -o json
        if ($LASTEXITCODE -eq 0 -and $pvcResponse) {
            try {
                $pvcPhase = (($pvcResponse -join "`n") | ConvertFrom-Json).status.phase
            } catch {
            }
        }

        if ($pendingPhase -eq 'Pending' -and $pvcPhase -eq 'Pending') {
            Write-Host "Fixture pods ready: $pendingPod and $pvcPod are Pending for different scheduling reasons."
            exit 0
        }
        if ((Get-Date) -ge $deadline) {
            throw "Fixtures not ready within 180s (pending phase: $pendingPhase, pvc phase: $pvcPhase)"
        }
        Start-Sleep -Seconds 5
    }
}
finally {
    Remove-Item -LiteralPath $workDir -Force -Recurse -ErrorAction SilentlyContinue
}
