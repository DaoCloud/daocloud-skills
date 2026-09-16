$ErrorActionPreference = 'Stop'

if (-not $env:DCE_HOST) { throw 'DCE_HOST is required' }
if (-not $env:DCE_TOKEN) { throw 'DCE_TOKEN is required' }

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$templateDir = Join-Path $scriptDir 'task-template\dce-create-pod'
$destination = if ($args.Count -gt 0) { $args[0] } else { Join-Path $scriptDir '.runtime\tasks\dce-create-pod' }

if (-not (Test-Path -LiteralPath $templateDir -PathType Container)) {
    throw "Task template not found: $templateDir"
}

New-Item -ItemType Directory -Force -Path $destination | Out-Null
Copy-Item (Join-Path $templateDir 'task.yaml') $destination -Force
Copy-Item (Join-Path $templateDir 'verify.sh') $destination -Force
Copy-Item (Join-Path $templateDir 'cleanup.sh') $destination -Force

$prompt = Get-Content (Join-Path $templateDir 'prompt.template') -Raw
$prompt = $prompt.Replace('${DCE_HOST}', $env:DCE_HOST)
$dceToken = $env:DCE_TOKEN
if ($dceToken.StartsWith('Bearer ')) {
    $dceToken = $dceToken.Substring(7)
}
$prompt = $prompt.Replace('${DCE_TOKEN}', $dceToken)
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText((Join-Path $destination 'prompt.txt'), $prompt, $utf8NoBom)

Write-Host "Rendered task: $destination"
