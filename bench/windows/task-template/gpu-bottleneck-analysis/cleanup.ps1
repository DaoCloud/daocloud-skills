$ErrorActionPreference = 'Stop'

if (-not $env:DCE_HOST) { throw 'DCE_HOST is required' }
if (-not $env:DCE_TOKEN) { throw 'DCE_TOKEN is required' }
if (-not $env:K8S_AI_BENCH_GPU_CLUSTER) { throw 'K8S_AI_BENCH_GPU_CLUSTER is required (name of the GPU cluster to saturate, e.g. jinye-gpu-cluster-1)' }
if (-not $env:K8S_AI_BENCH_GPU_NAMESPACE) { throw 'K8S_AI_BENCH_GPU_NAMESPACE is required (namespace for the fixture Deployment, e.g. default)' }

$cluster = $env:K8S_AI_BENCH_GPU_CLUSTER
$namespace = $env:K8S_AI_BENCH_GPU_NAMESPACE
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
