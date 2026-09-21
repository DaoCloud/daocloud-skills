$ErrorActionPreference = 'Stop'

if (-not $env:DCE_HOST) { throw 'DCE_HOST is required' }
if (-not $env:DCE_TOKEN) { throw 'DCE_TOKEN is required' }

$cluster = if ($env:K8S_AI_BENCH_DIAG_CLUSTER) { $env:K8S_AI_BENCH_DIAG_CLUSTER } else { 'kpanda-global-cluster' }
$namespace = if ($env:K8S_AI_BENCH_DIAG_NAMESPACE) { $env:K8S_AI_BENCH_DIAG_NAMESPACE } else { 'default' }
$pendingPod = 'k8s-ai-bench-diag-pending-pod'
$pvcPod = 'k8s-ai-bench-diag-pvc-pod'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$promptPath = Join-Path $scriptDir 'prompt.txt'
$dceToken = $env:DCE_TOKEN
if ($dceToken.StartsWith('Bearer ')) {
    $dceToken = $dceToken.Substring(7)
}

$status = 0
try {
    $dceToken | & dce --insecure --hostname $env:DCE_HOST auth login `
        --auth-type bearer --with-token --skip-validate | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "DCE authentication failed with exit code $LASTEXITCODE"
    }

    foreach ($podName in @($pendingPod, $pvcPod)) {
        $deleteOutput = & dce --insecure --hostname $env:DCE_HOST container-management core delete-pod `
            --cluster $cluster --namespace $namespace --name $podName -o json 2>&1
        $deleteStatus = $LASTEXITCODE

        if ($deleteStatus -eq 0) {
            Write-Host "Deleted DCE Pod $podName."
            continue
        }

        $deleteText = $deleteOutput -join [Environment]::NewLine
        if ($deleteText -match '(?i)404|not found|does not exist') {
            Write-Host "DCE Pod $podName was already absent."
            continue
        }

        [Console]::Error.WriteLine($deleteText)
        $status = $deleteStatus
    }
    exit $status
}
finally {
    Remove-Item -LiteralPath $promptPath -Force -ErrorAction SilentlyContinue
}
