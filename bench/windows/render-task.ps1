$ErrorActionPreference = 'Stop'

if (-not $env:DCE_HOST) { throw 'DCE_HOST is required' }
if (-not $env:DCE_TOKEN) { throw 'DCE_TOKEN is required' }

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$task = if ($args.Count -gt 0) { $args[0] } else { 'dce-create-pod' }
$templateDir = Join-Path $scriptDir "task-template\$task"
$destination = Join-Path $scriptDir ".runtime\tasks\$task"

if (-not (Test-Path -LiteralPath $templateDir -PathType Container)) {
    $templates = (Get-ChildItem (Join-Path $scriptDir 'task-template') -Directory | ForEach-Object Name) -join ' '
    throw "Task template not found: $templateDir. Usage: .\render-task.ps1 [task-name]  Templates: $templates"
}

New-Item -ItemType Directory -Force -Path $destination | Out-Null
Copy-Item (Join-Path $templateDir 'task.yaml') (Join-Path $destination 'task.yaml') -Force
Copy-Item (Join-Path $templateDir 'verify.ps1') $destination -Force
Copy-Item (Join-Path $templateDir 'cleanup.ps1') $destination -Force
$setupSrc = Join-Path $templateDir 'setup.ps1'
if (Test-Path -LiteralPath $setupSrc -PathType Leaf) {
    Copy-Item $setupSrc $destination -Force
}

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
