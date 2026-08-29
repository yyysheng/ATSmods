param(
    [string]$ModRoot = (Join-Path $PSScriptRoot '..\src\mod')
)

$ErrorActionPreference = 'Stop'

$truckIds = @(
    'freightliner.cascadia2019',
    'freightliner.cascadia2024',
    'intnational.9900i',
    'intnational.lonestar',
    'intnational.lt',
    'kenworth.t680',
    'kenworth.t680_2022',
    'kenworth.w900',
    'mack.anthem',
    'mack.pinnacle',
    'peterbilt.389',
    'peterbilt.579',
    'volvo.vnl',
    'volvo.vnl2018',
    'volvo.vnl2025',
    'volvo.vnr_e',
    'westernstar.49x',
    'westernstar.5700xe',
    'westernstar.57x'
)

$definitionRoot = Join-Path $ModRoot 'def\vehicle\truck'
for ($index = 0; $index -lt $truckIds.Count; $index++) {
    $truckId = $truckIds[$index]
    $directory = Join-Path $definitionRoot "$truckId\accessory\toyhang"
    New-Item -ItemType Directory -Path $directory -Force | Out-Null
    $unitId = 'revassist.ats{0:D2}.toyhang' -f ($index + 1)
    $content = @"
SiiNunit
{
accessory_addon_int_data : $unitId
{
    name: "Reverse Assist Anchor"
    price: 1
    unlock: 0
    icon: "toyhang/dice_pr"
    part_type: aftermarket

    interior_model: "/model/reverse_assist/accessory_anchor.pmd"
    exterior_model: "/model/reverse_assist/accessory_anchor.pmd"
}
}
"@
    [IO.File]::WriteAllText(
        (Join-Path $directory 'revassist.sii'),
        $content,
        [Text.UTF8Encoding]::new($false))
}

Write-Host ("Generated {0} ATS toyhang anchor definitions." -f $truckIds.Count)
