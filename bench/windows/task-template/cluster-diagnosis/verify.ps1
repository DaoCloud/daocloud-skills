$ErrorActionPreference = 'Stop'

if (-not $env:DCE_HOST) { throw 'DCE_HOST is required' }
if (-not $env:DCE_TOKEN) { throw 'DCE_TOKEN is required' }
if (-not $env:K8S_AI_BENCH_TASK_OUTPUT_DIR) {
    throw 'K8S_AI_BENCH_TASK_OUTPUT_DIR is required'
}

$cluster = 'kpanda-global-cluster'
$namespace = 'default'
$pendingPod = 'k8s-ai-bench-diag-pending-pod'
$cfgPod = 'k8s-ai-bench-diag-cfg-pod'

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
if (-not (Select-String -LiteralPath $logPath -Pattern "Pod: $namespace/$cfgPod" -SimpleMatch -Quiet)) {
    throw "Agent did not report $cfgPod as an abnormal Pod"
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

    $cfgPath = Join-Path $responseDir 'cfg.json'
    & dce --insecure --hostname $env:DCE_HOST container-management core get-pod `
        --cluster $cluster --namespace $namespace --name $cfgPod -o json > $cfgPath
    if ($LASTEXITCODE -ne 0) {
        throw "DCE Pod query failed with exit code $LASTEXITCODE"
    }

    $pending = Get-Content -LiteralPath $pendingPath -Raw | ConvertFrom-Json
    if ($pending.metadata.name -ne $pendingPod -or $pending.metadata.namespace -ne $namespace) {
        throw "Unexpected pending fixture identity: $($pending.metadata.namespace)/$($pending.metadata.name)"
    }
    if ($pending.status.phase -ne 'Pending') {
        throw "Pending fixture is not Pending: $($pending.status.phase)"
    }

    $cfg = Get-Content -LiteralPath $cfgPath -Raw | ConvertFrom-Json
    if ($cfg.metadata.name -ne $cfgPod -or $cfg.metadata.namespace -ne $namespace) {
        throw "Unexpected cfg fixture identity: $($cfg.metadata.namespace)/$($cfg.metadata.name)"
    }
    $reasons = @()
    foreach ($state in @($cfg.status.containerStatuses)) {
        if ($state.state.waiting.reason) {
            $reasons += $state.state.waiting.reason
        }
    }
    if (-not ($reasons -contains 'CreateContainerConfigError')) {
        throw "Cfg fixture is not in CreateContainerConfigError: [$($reasons -join ', ')]"
    }

    Write-Host "DCE API verified both fixtures intact: $pendingPod Pending, $cfgPod CreateContainerConfigError."
}
finally {
    Remove-Item -LiteralPath $responseDir -Force -Recurse -ErrorAction SilentlyContinue
}
