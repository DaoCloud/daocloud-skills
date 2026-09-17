$ErrorActionPreference = 'Stop'

$version = if ($env:K8S_AI_BENCH_VERSION) { $env:K8S_AI_BENCH_VERSION } else { 'v0.1.0' }
$repository = if ($env:K8S_AI_BENCH_REPOSITORY) { $env:K8S_AI_BENCH_REPOSITORY } else { 'DaoCloud/ai-skills-bench' }
$dceVersion = if ($env:DCE_CLI_VERSION) { $env:DCE_CLI_VERSION } else { 'v0.2.0-rc.12' }
$dceRepository = if ($env:DCE_CLI_REPOSITORY) { $env:DCE_CLI_REPOSITORY } else { 'DaoCloud/daocloud-skills' }
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

    if (-not (Get-Command dce.exe -ErrorAction SilentlyContinue)) {
        $dceArchive = "dce-$dceVersion-windows-$architecture.zip"
        $dceUrl = "https://github.com/$dceRepository/releases/download/$dceVersion/$dceArchive"
        $dceArchivePath = Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName())
        $dceExtractPath = Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName())
        try {
            New-Item -ItemType Directory -Force -Path $dceExtractPath | Out-Null
            Write-Host "Downloading $dceUrl"
            Invoke-WebRequest -Uri $dceUrl -OutFile $dceArchivePath
            Expand-Archive -Path $dceArchivePath -DestinationPath $dceExtractPath -Force
            $dceBinary = Get-ChildItem -LiteralPath $dceExtractPath -Filter 'dce.exe' -File -Recurse |
                Select-Object -First 1
            if (-not $dceBinary) {
                throw "dce.exe not found in $dceArchive"
            }
            Copy-Item -LiteralPath $dceBinary.FullName -Destination (Join-Path $destination 'dce.exe') -Force
            Write-Host "Installed dce CLI $dceVersion in $destination"
        }
        finally {
            Remove-Item -LiteralPath $dceArchivePath -Force -ErrorAction SilentlyContinue
            Remove-Item -LiteralPath $dceExtractPath -Recurse -Force -ErrorAction SilentlyContinue
        }
    } else {
        Write-Host 'Using existing dce CLI from PATH'
    }

    Write-Host "Installed k8s-ai-bench $version binaries in $destination"
}
finally {
    Remove-Item -LiteralPath $archivePath -Force -ErrorAction SilentlyContinue
}
