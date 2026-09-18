$ErrorActionPreference = 'Stop'

if (-not $env:DCE_HOST) { throw 'DCE_HOST is required' }
if (-not $env:DCE_TOKEN) { throw 'DCE_TOKEN is required' }
if (-not $env:K8S_AI_BENCH_TASK_OUTPUT_DIR) {
    throw 'K8S_AI_BENCH_TASK_OUTPUT_DIR is required'
}

$logPath = Join-Path $env:K8S_AI_BENCH_TASK_OUTPUT_DIR 'log.txt'
if (-not (Test-Path -LiteralPath $logPath -PathType Leaf)) {
    throw "Task log not found: $logPath"
}
if (-not (Select-String -LiteralPath $logPath -Pattern 'DCE_POD_CREATED_OK' -SimpleMatch -Quiet)) {
    throw 'Agent did not emit DCE_POD_CREATED_OK'
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
        --cluster kpanda-global-cluster --namespace default `
        --name k8s-ai-bench-dce-pod -o json > $responsePath
    if ($LASTEXITCODE -ne 0) {
        throw "DCE Pod query failed with exit code $LASTEXITCODE"
    }

    $pod = Get-Content -LiteralPath $responsePath -Raw | ConvertFrom-Json
    if ($pod.metadata.name -ne 'k8s-ai-bench-dce-pod') {
        throw "Unexpected Pod name: $($pod.metadata.name)"
    }
    if ($pod.metadata.namespace -ne 'default') {
        throw "Unexpected Pod namespace: $($pod.metadata.namespace)"
    }
    if (-not $pod.spec.containers -or $pod.spec.containers[0].image -ne 'nginx:stable') {
        $image = if ($pod.spec.containers) { $pod.spec.containers[0].image } else { $null }
        throw "Unexpected first container image: $image"
    }

    Write-Host 'DCE API verified k8s-ai-bench-dce-pod in default with image nginx:stable.'
}
finally {
    Remove-Item -LiteralPath $responsePath -Force -ErrorAction SilentlyContinue
}
