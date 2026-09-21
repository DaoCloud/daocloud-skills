$ErrorActionPreference = 'Stop'

if (-not $env:DCE_HOST) { throw 'DCE_HOST is required' }
if (-not $env:DCE_TOKEN) { throw 'DCE_TOKEN is required' }

# Target environment. Override with K8S_AI_BENCH_GPU_CLUSTER /
# K8S_AI_BENCH_GPU_NAMESPACE when running against a different DCE.
$cluster = if ($env:K8S_AI_BENCH_GPU_CLUSTER) { $env:K8S_AI_BENCH_GPU_CLUSTER } else { 'jinye-gpu-cluster-1' }
$namespace = if ($env:K8S_AI_BENCH_GPU_NAMESPACE) { $env:K8S_AI_BENCH_GPU_NAMESPACE } else { 'default' }
$deployment = 'k8s-ai-bench-gpu-saturate'

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

    $deleteOutput = & dce --insecure --hostname $env:DCE_HOST container-management apps delete-deployment `
        --cluster $cluster --namespace $namespace --name $deployment -o json 2>&1
    $deleteStatus = $LASTEXITCODE

    if ($deleteStatus -eq 0) {
        Write-Host "Deleted DCE Deployment $deployment."
    } else {
        $deleteText = $deleteOutput -join [Environment]::NewLine
        if ($deleteText -match '(?i)404|not found|does not exist') {
            Write-Host "DCE Deployment $deployment was already absent."
        } else {
            [Console]::Error.WriteLine($deleteText)
            $status = $deleteStatus
        }
    }
    exit $status
}
finally {
    Remove-Item -LiteralPath $promptPath -Force -ErrorAction SilentlyContinue
}
