$ErrorActionPreference = 'Stop'

if (-not $env:DCE_HOST) { throw 'DCE_HOST is required' }
if (-not $env:DCE_TOKEN) { throw 'DCE_TOKEN is required' }

$cluster = 'kpanda-global-cluster'
$namespace = 'default'
$podName = 'k8s-ai-bench-diag-pod'
$fixtureImage = 'nginx:stable-nonexistent'

$dceToken = $env:DCE_TOKEN
if ($dceToken.StartsWith('Bearer ')) {
    $dceToken = $dceToken.Substring(7)
}

$bodyPath = [System.IO.Path]::GetTempFileName()
try {
    $dceToken | & dce --insecure --hostname $env:DCE_HOST auth login `
        --auth-type bearer --with-token --skip-validate | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "DCE authentication failed with exit code $LASTEXITCODE"
    }

    # Idempotency: remove any leftover fixture from a previous aborted run.
    & dce --insecure --hostname $env:DCE_HOST container-management core delete-pod `
        --cluster $cluster --namespace $namespace --name $podName -o json | Out-Null

    $podJson = @"
{
  "apiVersion": "v1",
  "kind": "Pod",
  "metadata": {
    "name": "$podName",
    "namespace": "$namespace"
  },
  "spec": {
    "containers": [
      {
        "name": "main",
        "image": "$fixtureImage"
      }
    ]
  }
}
"@
    $bodyJson = [pscustomobject]@{ data = $podJson } | ConvertTo-Json -Compress
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($bodyPath, $bodyJson, $utf8NoBom)

    & dce --insecure --hostname $env:DCE_HOST container-management apps create-workload-by-json `
        --cluster $cluster --namespace $namespace --kind pods --file $bodyPath | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "Fixture Pod creation failed with exit code $LASTEXITCODE"
    }

    $deadline = (Get-Date).AddSeconds(180)
    while ($true) {
        $reason = $null
        $response = & dce --insecure --hostname $env:DCE_HOST container-management core get-pod `
            --cluster $cluster --namespace $namespace --name $podName -o json
        if ($LASTEXITCODE -eq 0 -and $response) {
            try {
                $pod = ($response -join "`n") | ConvertFrom-Json
                foreach ($state in @($pod.status.containerStatuses)) {
                    if ($state.state.waiting.reason) {
                        $reason = $state.state.waiting.reason
                        break
                    }
                }
            } catch {
            }
        }
        if ($reason -eq 'ImagePullBackOff' -or $reason -eq 'ErrImagePull') {
            Write-Host "Fixture pod $podName is failing image pulls ($reason)."
            exit 0
        }
        if ((Get-Date) -ge $deadline) {
            throw "Fixture pod did not reach an image-pull failure state within 180s (last reason: $reason)"
        }
        Start-Sleep -Seconds 5
    }
}
finally {
    Remove-Item -LiteralPath $bodyPath -Force -ErrorAction SilentlyContinue
}
