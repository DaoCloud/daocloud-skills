$ErrorActionPreference = 'Stop'

if (-not $env:DCE_HOST) { throw 'DCE_HOST is required' }
if (-not $env:DCE_TOKEN) { throw 'DCE_TOKEN is required' }
if (-not $env:K8S_AI_BENCH_TASK_OUTPUT_DIR) {
    throw 'K8S_AI_BENCH_TASK_OUTPUT_DIR is required'
}
if (-not $env:K8S_AI_BENCH_GPU_CLUSTER) { throw 'K8S_AI_BENCH_GPU_CLUSTER is required (name of the GPU cluster to saturate, e.g. jinye-gpu-cluster-1)' }
if (-not $env:K8S_AI_BENCH_GPU_NAMESPACE) { throw 'K8S_AI_BENCH_GPU_NAMESPACE is required (namespace for the fixture Deployment, e.g. default)' }

$cluster = $env:K8S_AI_BENCH_GPU_CLUSTER
$namespace = $env:K8S_AI_BENCH_GPU_NAMESPACE
$deployment = 'k8s-ai-bench-gpu-saturate'

$logPath = Join-Path $env:K8S_AI_BENCH_TASK_OUTPUT_DIR 'log.txt'
if (-not (Test-Path -LiteralPath $logPath -PathType Leaf)) {
    throw "Task log not found: $logPath"
}
if (-not (Select-String -LiteralPath $logPath -Pattern 'GPU_BOTTLENECK_OK' -SimpleMatch -Quiet)) {
    throw 'Agent did not emit GPU_BOTTLENECK_OK'
}

$censusMatch = Select-String -LiteralPath $logPath -Pattern "Census: $cluster mode=VGPU total=(\d+) allocated=(\d+)" |
    Select-Object -First 1
if (-not $censusMatch) {
    throw "Agent did not report a VGPU census line for $cluster"
}
$reportedTotal = [int]$censusMatch.Matches[0].Groups[1].Value
$reportedAllocated = [int]$censusMatch.Matches[0].Groups[2].Value

$bottleneckMatch = Select-String -LiteralPath $logPath -Pattern "Bottleneck: $cluster \((GPU|VGPU), (compute|scheduling|vram)\)" |
    Select-Object -First 1
if (-not $bottleneckMatch) {
    throw "Agent did not identify $cluster as the first bottleneck"
}
$bottleneckMode = $bottleneckMatch.Matches[0].Groups[1].Value
$bottleneckConstraint = $bottleneckMatch.Matches[0].Groups[2].Value
if ($bottleneckConstraint -eq 'compute') {
    throw 'Agent reported a compute constraint, but GPU core utilization is idle; expected scheduling (or vram for the GPU mode)'
}
if ($bottleneckMode -eq 'VGPU' -and $bottleneckConstraint -ne 'scheduling') {
    throw "Agent reported constraint $bottleneckConstraint for VGPU mode, but only scheduling is saturated there"
}

$dceToken = $env:DCE_TOKEN
if ($dceToken.StartsWith('Bearer ')) {
    $dceToken = $dceToken.Substring(7)
}

function Get-VgpuMetric {
    param([string]$Query)
    $response = & dce --insecure --hostname $env:DCE_HOST insight metric query-metric `
        --cluster-name $cluster --query $Query -o json
    if ($LASTEXITCODE -ne 0 -or -not $response) { return 0 }
    try {
        $data = ($response -join "`n") | ConvertFrom-Json
    } catch {
        return 0
    }
    foreach ($vector in $data.vector) {
        if ($vector.metric.mode -eq 'VGPU') {
            return [int][double]$vector.values.value
        }
    }
    return 0
}

$responseDir = New-Item -ItemType Directory -Path (Join-Path ([System.IO.Path]::GetTempPath()) ("gpu-bottleneck-verify-" + [System.IO.Path]::GetRandomFileName())) -Force
try {
    $dceToken | & dce --insecure --hostname $env:DCE_HOST auth login `
        --auth-type bearer --with-token --skip-validate | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "DCE authentication failed with exit code $LASTEXITCODE"
    }

    $liveTotal = Get-VgpuMetric 'sum(kpanda_gpu_count) by (mode)'
    $liveAllocated = Get-VgpuMetric 'sum(kpanda_gpu_allocated) by (mode)'

    if ($reportedTotal -ne $liveTotal) {
        throw "Reported VGPU total $reportedTotal does not match live value $liveTotal"
    }
    if ($reportedAllocated -ne $liveAllocated) {
        throw "Reported VGPU allocated $reportedAllocated does not match live value $liveAllocated"
    }
    if ($liveAllocated -ne $liveTotal) {
        throw "Fixture no longer saturates the VGPU pool (allocated $liveAllocated / total $liveTotal)"
    }

    $deploymentPath = Join-Path $responseDir 'deployment.json'
    & dce --insecure --hostname $env:DCE_HOST container-management apps get-deployment `
        --cluster $cluster --namespace $namespace --name $deployment -o json > $deploymentPath
    if ($LASTEXITCODE -ne 0) {
        throw "DCE Deployment query failed with exit code $LASTEXITCODE"
    }

    $resource = Get-Content -LiteralPath $deploymentPath -Raw | ConvertFrom-Json
    if ($resource.metadata.name -ne $deployment -or $resource.metadata.namespace -ne $namespace) {
        throw "Unexpected fixture identity: $($resource.metadata.namespace)/$($resource.metadata.name)"
    }

    Write-Host "DCE API verified fixture intact: $deployment is present in $namespace."
    Write-Host "Verified: agent identified $cluster ($bottleneckMode, $bottleneckConstraint) as the first bottleneck with numbers matching the live metrics API (VGPU total=$liveTotal, allocated=$liveAllocated)."
}
finally {
    Remove-Item -LiteralPath $responseDir -Force -Recurse -ErrorAction SilentlyContinue
}
