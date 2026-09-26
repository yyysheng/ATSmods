$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$source = (Resolve-Path (Join-Path $root 'src\mod')).Path
$workshopRoot = (Resolve-Path (Join-Path $root 'workshop')).Path
$versionFolders = @('160_content', '161_content')
$utf8NoBom = [Text.UTF8Encoding]::new($false)

foreach ($folderName in $versionFolders) {
    $destination = Join-Path $workshopRoot $folderName
    $resolvedDestination = [IO.Path]::GetFullPath($destination)
    $expectedDestination = [IO.Path]::GetFullPath((Join-Path $workshopRoot $folderName))
    if (-not [string]::Equals($resolvedDestination, $expectedDestination, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Unsafe Workshop staging path: $resolvedDestination"
    }
    if ($folderName -notin $versionFolders) { throw "Unexpected version package: $folderName" }

    if (Test-Path -LiteralPath $destination) {
        $existing = (Resolve-Path -LiteralPath $destination).Path
        if (-not [string]::Equals($existing, $expectedDestination, [StringComparison]::OrdinalIgnoreCase)) {
            throw "Refusing to replace a path outside the expected Workshop package: $existing"
        }
        Remove-Item -LiteralPath $existing -Recurse -Force
    }
    New-Item -ItemType Directory -Path $destination | Out-Null
    Get-ChildItem -LiteralPath $source -Force | Copy-Item -Destination $destination -Recurse -Force

    $manifestPath = Join-Path $destination 'manifest.sii'
    $manifest = [IO.File]::ReadAllText($manifestPath)
    $manifest = [regex]::Replace($manifest, 'package_version\s*:\s*"\d+\.\d+\.\d+"', 'package_version: "0.11.1"')
    $manifest = [regex]::Replace($manifest, '(?m)^\s*(?:display_name\s*:|compatible_versions\[\]\s*:).*(?:\r?\n|$)', '')
    [IO.File]::WriteAllText($manifestPath, $manifest, $utf8NoBom)
}

$rootEntries = Get-ChildItem -LiteralPath $workshopRoot -Force
$allowedFiles = @('versions.sii')
$allowedFolders = @('160_content', '161_content', 'universal_info')
$unexpected = $rootEntries | Where-Object {
    if ($_.PSIsContainer) { $_.Name -notin $allowedFolders }
    else { $_.Name -notin $allowedFiles }
}
if ($unexpected) { throw "Workshop root may contain only versions.sii and package folders; found: $($unexpected.Name -join ', ')" }

foreach ($folderName in $versionFolders) {
    $manifest = Get-Content -Raw (Join-Path (Join-Path $workshopRoot $folderName) 'manifest.sii')
    if ($manifest -notmatch 'package_version\s*:\s*"0\.11\.1"') { throw "Version was not updated in $folderName" }
    if ($manifest -match '(?m)^\s*(?:display_name\s*:|compatible_versions\[\]\s*:)') { throw "Uploader-managed fields remain in $folderName/manifest.sii" }
}

Write-Output "Prepared ATS 1.60 and 1.61 Workshop content packages at $workshopRoot"
