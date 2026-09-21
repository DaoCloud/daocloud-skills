$ErrorActionPreference = 'Stop'

if (-not $env:DCE_HOST) { throw 'DCE_HOST is required' }
if (-not $env:DCE_TOKEN) { throw 'DCE_TOKEN is required' }

# Target environment. Override with K8S_AI_BENCH_GPU_CLUSTER /
# K8S_AI_BENCH_GPU_NAMESPACE when running against a different DCE.
$cluster = if ($env:K8S_AI_BENCH_GPU_CLUSTER) { $env:K8S_AI_BENCH_GPU_CLUSTER } else { 'jinye-gpu-cluster-1' }
$namespace = if ($env:K8S_AI_BENCH_GPU_NAMESPACE) { $env:K8S_AI_BENCH_GPU_NAMESPACE } else { 'default' }
$deployment = 'k8s-ai-bench-gpu-saturate'

$dceToken = $env:DCE_TOKEN
if ($dceToken.StartsWith('Bearer ')) {
    $dceToken = $dceToken.Substring(7)
}

# Returns the integer value of a PromQL query for mode=VGPU on the target
# cluster, or 0 when the vector has no VGPU series or the query fails.
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

# Returns @{ Bound = n; Total = n } pod counts for the fixture deployment.
function Get-FixturePodCounts {
    $response = & dce --insecure --hostname $env:DCE_HOST container-management core list-pods `
        --cluster $cluster --namespace $namespace -o json
    if ($LASTEXITCODE -ne 0 -or -not $response) { return @{ Bound = 0; Total = 0 } }
    try {
        $data = ($response -join "`n") | ConvertFrom-Json
    } catch {
        return @{ Bound = 0; Total = 0 }
    }
    $bound = 0
    $total = 0
    foreach ($pod in $data.items) {
        if ($pod.metadata.name -like "$deployment*") {
            $total++
            if ($pod.spec.nodeName) { $bound++ }
        }
    }
    return @{ Bound = $bound; Total = $total }
}

# Deletes fixture pods that are still unschedulable. Fresh replacement pods
# enter the scheduling queue without the exponential backoff history, which is
# what makes HAMi vGPU binding converge in seconds instead of minutes.
function Reset-UnboundPods {
    $response = & dce --insecure --hostname $env:DCE_HOST container-management core list-pods `
        --cluster $cluster --namespace $namespace -o json
    if ($LASTEXITCODE -ne 0 -or -not $response) { return }
    try {
        $data = ($response -join "`n") | ConvertFrom-Json
    } catch {
        return
    }
    foreach ($pod in $data.items) {
        if ($pod.metadata.name -like "$deployment*" -and -not $pod.spec.nodeName) {
            & dce --insecure --hostname $env:DCE_HOST container-management core delete-pod `
                --cluster $cluster --namespace $namespace --name $pod.metadata.name -o json | Out-Null
        }
    }
}

$workDir = New-Item -ItemType Directory -Path (Join-Path ([System.IO.Path]::GetTempPath()) ("gpu-bottleneck-setup-" + [System.IO.Path]::GetRandomFileName())) -Force
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
try {
    $dceToken | & dce --insecure --hostname $env:DCE_HOST auth login `
        --auth-type bearer --with-token --skip-validate | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "DCE authentication failed with exit code $LASTEXITCODE"
    }

    # Idempotency: remove any leftover fixture from a previous aborted run.
    & dce --insecure --hostname $env:DCE_HOST container-management apps delete-deployment `
        --cluster $cluster --namespace $namespace --name $deployment -o json | Out-Null

    # Wait for lingering allocations from a previous run to clear so the
    # census baseline starts at zero. Terminating HAMi pods can take several
    # minutes to release their vGPU slices; a release mid-run would invalidate
    # the census cross-check in verify.ps1.
    $baselineDeadline = (Get-Date).AddSeconds(600)
    while ($true) {
        $baselineAllocated = Get-VgpuMetric 'sum(kpanda_gpu_allocated) by (mode)'
        if ($baselineAllocated -eq 0) {
            break
        }
        if ((Get-Date) -ge $baselineDeadline) {
            Write-Host "Warning: VGPU allocated=$baselineAllocated before fixture creation; continuing anyway"
            break
        }
        Start-Sleep -Seconds 30
    }

    # Size the fixture to the live vGPU capacity reported by kpanda.
    $vgpuTotal = Get-VgpuMetric 'sum(kpanda_gpu_count) by (mode)'
    if ($vgpuTotal -lt 1) {
        throw "No VGPU capacity reported for $cluster (kpanda_gpu_count mode=VGPU is empty)"
    }

    # Fixture: a Deployment whose replicas request one vGPU slice each. No
    # node pinning is needed: the HAMi scheduler only admits vGPU requests
    # onto nodes that expose vGPU devices. The intentionally nonexistent
    # image keeps every pod Pending after binding, so the pods reserve vGPU
    # allocation (kpanda_gpu_allocated counts bound pods) without consuming
    # any real GPU compute or memory.
    $deploymentJson = @"
{
  "apiVersion": "apps/v1",
  "kind": "Deployment",
  "metadata": {
    "name": "$deployment",
    "namespace": "$namespace"
  },
  "spec": {
    "replicas": $vgpuTotal,
    "selector": {"matchLabels": {"app": "$deployment"}},
    "template": {
      "metadata": {"labels": {"app": "$deployment"}},
      "spec": {
        "containers": [
          {
            "name": "main",
            "image": "nginx:stable-nonexistent",
            "resources": {
              "requests": {"cpu": "100m", "memory": "128Mi", "nvidia.com/vgpu": "1", "nvidia.com/gpucores": "20", "nvidia.com/gpumem": "1024"},
              "limits": {"cpu": "250m", "memory": "256Mi", "nvidia.com/vgpu": "1", "nvidia.com/gpucores": "20", "nvidia.com/gpumem": "1024"}
            }
          }
        ]
      }
    }
  }
}
"@

    $bodyJson = [pscustomobject]@{ data = $deploymentJson } | ConvertTo-Json -Compress
    $bodyPath = Join-Path $workDir 'deployment-body.json'
    [System.IO.File]::WriteAllText($bodyPath, $bodyJson, $utf8NoBom)
    & dce --insecure --hostname $env:DCE_HOST container-management apps create-workload-by-json `
        --cluster $cluster --namespace $namespace --kind deployments --file $bodyPath | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "Fixture Deployment creation failed with exit code $LASTEXITCODE"
    }

    # Wait until the vGPU pool is fully allocated. Binding is retried by
    # deleting unschedulable pods; the allocated metric lags binding by a
    # scrape interval.
    $deadline = (Get-Date).AddSeconds(600)
    $lastReset = Get-Date
    while ($true) {
        $counts = Get-FixturePodCounts
        $allocated = Get-VgpuMetric 'sum(kpanda_gpu_allocated) by (mode)'

        if ($allocated -ge $vgpuTotal) {
            Write-Host "Fixture ready: VGPU pool on $cluster saturated ($allocated/$vgpuTotal allocated, $($counts.Bound) fixture pods bound)."
            exit 0
        }

        if ($counts.Bound -lt $vgpuTotal -and ((Get-Date) - $lastReset).TotalSeconds -ge 45) {
            Reset-UnboundPods
            $lastReset = Get-Date
        }

        if ((Get-Date) -ge $deadline) {
            throw "VGPU pool not saturated within 600s (bound $($counts.Bound)/$($counts.Total), allocated $allocated/$vgpuTotal)"
        }
        Start-Sleep -Seconds 15
    }
}
finally {
    Remove-Item -LiteralPath $workDir -Force -Recurse -ErrorAction SilentlyContinue
}
