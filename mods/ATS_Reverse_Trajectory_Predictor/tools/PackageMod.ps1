param([Parameter(Mandatory=$true)][string]$Destination)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem
$source = (Resolve-Path (Join-Path $PSScriptRoot '../src/mod')).Path
$files = Get-ChildItem -LiteralPath $source -Recurse -File
foreach ($file in $files) {
    $relative = $file.FullName.Substring($source.Length + 1).Replace('\','/')
    if ($relative -match '^model/symbol/') { throw "Forbidden game symbol override: $relative" }
}
$runtime = Get-Content -Raw (Join-Path $PSScriptRoot '../src/entity_runtime/native_entity_runtime.cpp')
if ($runtime -match 'native_marker_visible|unsafe_apply_native_marker_target|trailer \+ 0x1120|trailer \+ 0x1124') { throw 'Native marker mutation regression detected.' }
$zip = [IO.Compression.ZipFile]::Open($Destination, [IO.Compression.ZipArchiveMode]::Create)
try {
    foreach ($file in $files) {
        $relative = $file.FullName.Substring($source.Length + 1).Replace('\','/')
        [IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip,$file.FullName,$relative,[IO.Compression.CompressionLevel]::Optimal) | Out-Null
    }
} finally { $zip.Dispose() }
$zip = [IO.Compression.ZipFile]::OpenRead($Destination)
try {
    foreach ($required in @('manifest.sii','material/reverse_assist/inv.mat','model/reverse_assist/accessory_anchor.pmd','model/reverse_assist/sweep_edge.pmd','model/reverse_assist/sweep_edge_blue.pmd')) {
        if (-not $zip.GetEntry($required)) { throw "Missing asset: $required" }
    }
    if ($zip.GetEntry('automat/40/408526e9278658d1.mat')) { throw 'Hand-authored invisible material must not be stored under automat/.' }
    $anchor = $zip.GetEntry('model/reverse_assist/accessory_anchor.pmd')
    $stream = $anchor.Open()
    try {
        $memory = [IO.MemoryStream]::new()
        try {
            $stream.CopyTo($memory)
            $anchorText = [Text.Encoding]::ASCII.GetString($memory.ToArray())
            if (-not $anchorText.Contains('/material/reverse_assist/inv.mat')) { throw 'Accessory helper model does not reference the validated invisible material.' }
            if ($anchorText.Contains('/automat/40/408526e9278658d1.mat')) { throw 'Legacy invisible material reference remains in the helper model.' }
        } finally { $memory.Dispose() }
    } finally { $stream.Dispose() }
} finally { $zip.Dispose() }
