param(
    [Parameter(Mandatory = $true)]
    [string]$ReferenceExecutable,
    [Parameter(Mandatory = $true)]
    [string]$TargetExecutable
)

$ErrorActionPreference = 'Stop'

function Read-PeImage {
    param([string]$Path)

    $bytes = [IO.File]::ReadAllBytes($Path)
    $peOffset = [BitConverter]::ToInt32($bytes, 0x3c)
    if ([Text.Encoding]::ASCII.GetString($bytes, $peOffset, 4) -ne "PE`0`0") {
        throw "Not a PE executable: $Path"
    }
    $sectionCount = [BitConverter]::ToUInt16($bytes, $peOffset + 6)
    $optionalSize = [BitConverter]::ToUInt16($bytes, $peOffset + 20)
    $sectionOffset = $peOffset + 24 + $optionalSize
    $sections = for ($index = 0; $index -lt $sectionCount; $index++) {
        $offset = $sectionOffset + 40 * $index
        $name = [Text.Encoding]::ASCII.GetString($bytes, $offset, 8).Trim([char]0)
        [pscustomobject]@{
            Name = $name
            VirtualSize = [BitConverter]::ToUInt32($bytes, $offset + 8)
            VirtualAddress = [BitConverter]::ToUInt32($bytes, $offset + 12)
            RawSize = [BitConverter]::ToUInt32($bytes, $offset + 16)
            RawOffset = [BitConverter]::ToUInt32($bytes, $offset + 20)
        }
    }
    [pscustomobject]@{ Path = $Path; Bytes = $bytes; Sections = $sections }
}

function Convert-RvaToOffset {
    param($Image, [uint32]$Rva)

    foreach ($section in $Image.Sections) {
        $span = [Math]::Max($section.VirtualSize, $section.RawSize)
        if ($Rva -ge $section.VirtualAddress -and $Rva -lt $section.VirtualAddress + $span) {
            return [int]($section.RawOffset + $Rva - $section.VirtualAddress)
        }
    }
    throw ('RVA 0x{0:X8} is not mapped in {1}' -f $Rva, $Image.Path)
}

function Convert-OffsetToRva {
    param($Image, [int]$Offset)

    foreach ($section in $Image.Sections) {
        if ($Offset -ge $section.RawOffset -and $Offset -lt $section.RawOffset + $section.RawSize) {
            return [uint32]($section.VirtualAddress + $Offset - $section.RawOffset)
        }
    }
    throw ('File offset 0x{0:X8} is not mapped in {1}' -f $Offset, $Image.Path)
}

function Find-Pattern {
    param([byte[]]$Haystack, [byte[]]$Needle)

    $hits = [Collections.Generic.List[int]]::new()
    $lastStart = $Haystack.Length - $Needle.Length
    for ($start = 0; $start -le $lastStart; $start++) {
        if ($Haystack[$start] -ne $Needle[0]) { continue }
        $matched = $true
        for ($index = 1; $index -lt $Needle.Length; $index++) {
            if ($Haystack[$start + $index] -ne $Needle[$index]) {
                $matched = $false
                break
            }
        }
        if ($matched) { $hits.Add($start) }
    }
    return $hits
}

$symbols = [ordered]@{
    model_load = 0x015184f0
    model_activate = 0x015288d0
    model_transfer = 0x0032cfc0
    model_parameter_init = 0x0040cc30
    vehicle_accessory_collect = 0x00648640
    vehicle_addon_finalize = 0x00648e80
    render_entry_populate = 0x00311bb0
    final_base_model_create = 0x015174d0
    final_model_create = 0x01517420
    final_accessory_insert = 0x00537740
    set_parent = 0x013149c0
    set_transform = 0x01314a80
    vehicle_render_dispatch = 0x00772020
    trailer_visual_update = 0x00614190
    trailer_render = 0x006148f0
}

$reference = Read-PeImage $ReferenceExecutable
$target = Read-PeImage $TargetExecutable

foreach ($entry in $symbols.GetEnumerator()) {
    $referenceOffset = Convert-RvaToOffset $reference ([uint32]$entry.Value)
    $result = $null
    foreach ($length in 96, 80, 64, 48, 32, 24, 20, 16) {
        $pattern = [byte[]]::new($length)
        [Array]::Copy($reference.Bytes, $referenceOffset, $pattern, 0, $length)
        $hits = @(Find-Pattern $target.Bytes $pattern)
        if ($hits.Count -eq 1) {
            $targetRva = Convert-OffsetToRva $target $hits[0]
            $result = [pscustomobject]@{
                Symbol = $entry.Key
                ReferenceRva = ('0x{0:X8}' -f $entry.Value)
                TargetRva = ('0x{0:X8}' -f $targetRva)
                UniqueBytes = $length
                Signature16 = (($pattern[0..15] | ForEach-Object { '{0:X2}' -f $_ }) -join ' ')
            }
            break
        }
    }
    if ($null -eq $result) {
        $result = [pscustomobject]@{
            Symbol = $entry.Key
            ReferenceRva = ('0x{0:X8}' -f $entry.Value)
            TargetRva = 'NOT_UNIQUE_OR_MISSING'
            UniqueBytes = 0
            Signature16 = ''
        }
    }
    $result
}
