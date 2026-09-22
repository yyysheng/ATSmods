param(
    [string]$ModelRoot = (Join-Path $PSScriptRoot '..\src\mod\model\reverse_assist')
)

$ErrorActionPreference = 'Stop'
$path = Join-Path $ModelRoot 'accessory_anchor.pmd'
$visibleMaterial = '/automat/f5/f57370b76733c5aa.mat'
$legacyInvisibleMaterial = '/automat/40/408526e9278658d1.mat'
$invisibleMaterial = '/material/reverse_assist/inv.mat'

$bytes = [IO.File]::ReadAllBytes($path)
$visibleBytes = [Text.Encoding]::ASCII.GetBytes($visibleMaterial)
$legacyInvisibleBytes = [Text.Encoding]::ASCII.GetBytes($legacyInvisibleMaterial)
$invisibleBytes = [Text.Encoding]::ASCII.GetBytes($invisibleMaterial)

function Find-ByteSequence {
    param([byte[]]$Buffer, [byte[]]$Needle)
    for ($offset = 0; $offset -le $Buffer.Length - $Needle.Length; $offset++) {
        $matches = $true
        for ($index = 0; $index -lt $Needle.Length; $index++) {
            if ($Buffer[$offset + $index] -ne $Needle[$index]) {
                $matches = $false
                break
            }
        }
        if ($matches) { return $offset }
    }
    return -1
}

$sourceMaterials = @($invisibleBytes, $legacyInvisibleBytes)
if ($sourceMaterials | Where-Object { $_.Length -ne $visibleBytes.Length }) {
    throw 'Material paths must have identical byte lengths.'
}

foreach ($sourceMaterial in $sourceMaterials) {
    $materialOffset = Find-ByteSequence $bytes $sourceMaterial
    if ($materialOffset -ge 0) {
        [Array]::Copy($visibleBytes, 0, $bytes, $materialOffset, $visibleBytes.Length)
        [IO.File]::WriteAllBytes($path, $bytes)
        Write-Output $path
        exit 0
    }
}

if ((Find-ByteSequence $bytes $visibleBytes) -ge 0) {
    Write-Output $path
    exit 0
}
throw "Expected invisible material reference was not found in $path"
