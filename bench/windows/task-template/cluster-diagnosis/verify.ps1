$ErrorActionPreference = 'Stop'

if (-not $env:DCE_HOST) { throw 'DCE_HOST is required' }
if (-not $env:DCE_TOKEN) { throw 'DCE_TOKEN is required' }
if (-not $env:K8S_AI_BENCH_TASK_OUTPUT_DIR) {
    throw 'K8S_AI_BENCH_TASK_OUTPUT_DIR is required'
}

$cluster = 'kpanda-global-cluster'
$namespace = 'default'
$pendingPod = 'k8s-ai-bench-diag-pending-pod'
$pvcPod = 'k8s-ai-bench-diag-pvc-pod'

$logPath = Join-Path $env:K8S_AI_BENCH_TASK_OUTPUT_DIR 'log.txt'
if (-not (Test-Path -LiteralPath $logPath -PathType Leaf)) {
    throw "Task log not found: $logPath"
}
if (-not (Select-String -LiteralPath $logPath -Pattern 'CLUSTER_DIAGNOSIS_OK' -SimpleMatch -Quiet)) {
    throw 'Agent did not emit CLUSTER_DIAGNOSIS_OK'
}
if (-not (Select-String -LiteralPath $logPath -Pattern "Pod: $namespace/$pendingPod" -SimpleMatch -Quiet)) {
    throw "Agent did not report $pendingPod as an abnormal Pod"
}
if (-not (Select-String -LiteralPath $logPath -Pattern "Pod: $namespace/$pvcPod" -SimpleMatch -Quiet)) {
    throw "Agent did not report $pvcPod as an abnormal Pod"
}

$dceToken = $env:DCE_TOKEN
if ($dceToken.StartsWith('Bearer ')) {
    $dceToken = $dceToken.Substring(7)
}

$responseDir = New-Item -ItemType Directory -Path (Join-Path ([System.IO.Path]::GetTempPath()) ("cluster-diagnosis-verify-" + [System.IO.Path]::GetRandomFileName())) -Force
try {
    $dceToken | & dce --insecure --hostname $env:DCE_HOST auth login `
        --auth-type bearer --with-token --skip-validate | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "DCE authentication failed with exit code $LASTEXITCODE"
    }

    $pendingPath = Join-Path $responseDir 'pending.json'
    & dce --insecure --hostname $env:DCE_HOST container-management core get-pod `
        --cluster $cluster --namespace $namespace --name $pendingPod -o json > $pendingPath
    if ($LASTEXITCODE -ne 0) {
        throw "DCE Pod query failed with exit code $LASTEXITCODE"
    }

    $pvcPath = Join-Path $responseDir 'pvc.json'
    & dce --insecure --hostname $env:DCE_HOST container-management core get-pod `
        --cluster $cluster --namespace $namespace --name $pvcPod -o json > $pvcPath
    if ($LASTEXITCODE -ne 0) {
        throw "DCE Pod query failed with exit code $LASTEXITCODE"
    }

    foreach ($fixture in @(@{ Path = $pendingPath; Name = $pendingPod }, @{ Path = $pvcPath; Name = $pvcPod })) {
        $pod = Get-Content -LiteralPath $fixture.Path -Raw | ConvertFrom-Json
        if ($pod.metadata.name -ne $fixture.Name -or $pod.metadata.namespace -ne $namespace) {
            throw "Unexpected fixture identity: $($pod.metadata.namespace)/$($pod.metadata.name)"
        }
        if ($pod.status.phase -ne 'Pending') {
            throw "$($fixture.Name) is not Pending: $($pod.status.phase)"
        }
    }

    Write-Host "DCE API verified both fixtures intact: $pendingPod and $pvcPod are Pending."
}
finally {
    Remove-Item -LiteralPath $responseDir -Force -Recurse -ErrorAction SilentlyContinue
}
