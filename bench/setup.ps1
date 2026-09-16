$ErrorActionPreference = 'Stop'

$version = if ($env:K8S_AI_BENCH_VERSION) { $env:K8S_AI_BENCH_VERSION } else { 'v0.1.0' }
$repository = if ($env:K8S_AI_BENCH_REPOSITORY) { $env:K8S_AI_BENCH_REPOSITORY } else { 'DaoCloud/ai-skills-bench' }
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$destination = if ($args.Count -gt 0) { $args[0] } else { Join-Path $scriptDir '.build\bin' }

$rawArchitecture = if ($env:PROCESSOR_ARCHITEW6432) {
    $env:PROCESSOR_ARCHITEW6432
} else {
    $env:PROCESSOR_ARCHITECTURE
}
$architecture = switch ($rawArchitecture.ToUpperInvariant()) {
    'AMD64' { 'amd64' }
    'ARM64' { 'arm64' }
    default { throw "Unsupported Windows architecture: $rawArchitecture" }
}

$releaseVersion = $version.TrimStart('v')
$archive = "k8s-ai-bench_${releaseVersion}_windows_${architecture}.zip"
$url = "https://github.com/$repository/releases/download/$version/$archive"
$archivePath = Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName())

try {
    New-Item -ItemType Directory -Force -Path $destination | Out-Null
    Write-Host "Downloading $url"
    Invoke-WebRequest -Uri $url -OutFile $archivePath
    Expand-Archive -Path $archivePath -DestinationPath $destination -Force
    Write-Host "Installed k8s-ai-bench $version binaries in $destination"
}
finally {
    Remove-Item -LiteralPath $archivePath -Force -ErrorAction SilentlyContinue
}
