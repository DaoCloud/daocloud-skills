$ErrorActionPreference = 'Stop'

if (-not $env:DCE_HOST) { throw 'DCE_HOST is required' }
if (-not $env:DCE_TOKEN) { throw 'DCE_TOKEN is required' }

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$promptPath = Join-Path $scriptDir 'prompt.txt'
$dceToken = $env:DCE_TOKEN
if ($dceToken.StartsWith('Bearer ')) {
    $dceToken = $dceToken.Substring(7)
}

try {
    $dceToken | & dce --insecure --hostname $env:DCE_HOST auth login `
        --auth-type bearer --with-token --skip-validate | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "DCE authentication failed with exit code $LASTEXITCODE"
    }

    $deleteOutput = & dce --insecure --hostname $env:DCE_HOST container-management core delete-pod `
        --cluster kpanda-global-cluster --namespace default `
        --name k8s-ai-bench-diag-pod -o json 2>&1
    $deleteStatus = $LASTEXITCODE

    if ($deleteStatus -eq 0) {
        Write-Host 'Deleted DCE Pod k8s-ai-bench-diag-pod.'
        exit 0
    }

    $deleteText = $deleteOutput -join [Environment]::NewLine
    if ($deleteText -match '(?i)404|not found|does not exist') {
        Write-Host 'DCE Pod k8s-ai-bench-diag-pod was already absent.'
        exit 0
    }

    [Console]::Error.WriteLine($deleteText)
    exit $deleteStatus
}
finally {
    Remove-Item -LiteralPath $promptPath -Force -ErrorAction SilentlyContinue
}
