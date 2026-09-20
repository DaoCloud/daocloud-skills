$ErrorActionPreference = 'Stop'

if (-not $env:DCE_HOST) { throw 'DCE_HOST is required' }
if (-not $env:DCE_TOKEN) { throw 'DCE_TOKEN is required' }
if (-not $env:K8S_AI_BENCH_TASK_OUTPUT_DIR) {
    throw 'K8S_AI_BENCH_TASK_OUTPUT_DIR is required'
}

$cluster = 'kpanda-global-cluster'
$namespace = 'default'
$podName = 'k8s-ai-bench-diag-pod'
$fixtureImage = 'nginx:stable-nonexistent'

$logPath = Join-Path $env:K8S_AI_BENCH_TASK_OUTPUT_DIR 'log.txt'
if (-not (Test-Path -LiteralPath $logPath -PathType Leaf)) {
    throw "Task log not found: $logPath"
}
if (-not (Select-String -LiteralPath $logPath -Pattern 'POD_DIAGNOSIS_OK' -SimpleMatch -Quiet)) {
    throw 'Agent did not emit POD_DIAGNOSIS_OK'
}
if (-not (Select-String -LiteralPath $logPath -Pattern 'ImagePullBackOff|ErrImagePull' -Quiet)) {
    throw 'Agent did not identify an image-pull failure as the root cause'
}

$dceToken = $env:DCE_TOKEN
if ($dceToken.StartsWith('Bearer ')) {
    $dceToken = $dceToken.Substring(7)
}

$responsePath = [System.IO.Path]::GetTempFileName()
try {
    $dceToken | & dce --insecure --hostname $env:DCE_HOST auth login `
        --auth-type bearer --with-token --skip-validate | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "DCE authentication failed with exit code $LASTEXITCODE"
    }

    & dce --insecure --hostname $env:DCE_HOST container-management core get-pod `
        --cluster $cluster --namespace $namespace --name $podName -o json > $responsePath
    if ($LASTEXITCODE -ne 0) {
        throw "DCE Pod query failed with exit code $LASTEXITCODE"
    }

    $pod = Get-Content -LiteralPath $responsePath -Raw | ConvertFrom-Json
    if ($pod.metadata.name -ne $podName) {
        throw "Unexpected Pod name: $($pod.metadata.name)"
    }
    if ($pod.metadata.namespace -ne $namespace) {
        throw "Unexpected Pod namespace: $($pod.metadata.namespace)"
    }
    if (-not $pod.spec.containers -or $pod.spec.containers[0].image -ne $fixtureImage) {
        $image = if ($pod.spec.containers) { $pod.spec.containers[0].image } else { $null }
        throw "Unexpected first container image: $image"
    }

    $reasons = @()
    foreach ($state in @($pod.status.containerStatuses)) {
        if ($state.state.waiting.reason) {
            $reasons += $state.state.waiting.reason
        }
    }
    if (-not ($reasons -contains 'ImagePullBackOff' -or $reasons -contains 'ErrImagePull')) {
        throw "Fixture pod is not in an image-pull failure state: [$($reasons -join ', ')]"
    }

    Write-Host "DCE API verified $podName is still failing image pulls with image $fixtureImage."
}
finally {
    Remove-Item -LiteralPath $responsePath -Force -ErrorAction SilentlyContinue
}
