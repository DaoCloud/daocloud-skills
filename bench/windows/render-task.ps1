$ErrorActionPreference = 'Stop'

if (-not $env:DCE_HOST) { throw 'DCE_HOST is required' }
if (-not $env:DCE_TOKEN) { throw 'DCE_TOKEN is required' }

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$templateRoot = Join-Path $scriptDir 'task-template'
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

function RenderTask {
    param([string]$Task)

    $templateDir = Join-Path $templateRoot $Task
    $destination = Join-Path $scriptDir ".runtime\tasks\$Task"

    if (-not (Test-Path -LiteralPath $templateDir -PathType Container)) {
        $templates = (Get-ChildItem $templateRoot -Directory | ForEach-Object Name) -join ' '
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
    # Task templates may reference the target cluster through this placeholder;
    # kpanda-global-cluster is the built-in management cluster of every DCE.
    $diagCluster = if ($env:K8S_AI_BENCH_DIAG_CLUSTER) { $env:K8S_AI_BENCH_DIAG_CLUSTER } else { 'kpanda-global-cluster' }
    $prompt = $prompt.Replace('${K8S_AI_BENCH_DIAG_CLUSTER}', $diagCluster)
    [System.IO.File]::WriteAllText((Join-Path $destination 'prompt.txt'), $prompt, $utf8NoBom)

    Write-Host "Rendered task: $destination"
}

# With no arguments, render every template under task-template\. Pass a task
# name to render a single task. Which rendered tasks a matrix run executes is
# selected by its runs.taskPattern regex.
if ($args.Count -eq 0) {
    Get-ChildItem $templateRoot -Directory | ForEach-Object { RenderTask $_.Name }
} else {
    RenderTask $args[0]
}
