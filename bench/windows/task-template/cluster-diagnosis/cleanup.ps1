$ErrorActionPreference = 'Stop'

if (-not $env:DCE_HOST) { throw 'DCE_HOST is required' }
if (-not $env:DCE_TOKEN) { throw 'DCE_TOKEN is required' }

$cluster = 'kpanda-global-cluster'
$namespace = 'default'
$pendingPod = 'k8s-ai-bench-diag-pending-pod'
$cfgPod = 'k8s-ai-bench-diag-cfg-pod'

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

    foreach ($podName in @($pendingPod, $cfgPod)) {
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
