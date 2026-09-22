param(
    [string]$MsBuild = 'E:\Program Files\Microsoft Visual Studio\18\Community\MSBuild\Current\Bin\amd64\MSBuild.exe',
    [string]$AtsExecutable = 'E:\Program Files (x86)\Steam\steamapps\common\American Truck Simulator\bin\win_x64\amtrucks.exe'
)

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$build = Join-Path $root 'build'
$release = Join-Path $build 'release'
$staging = Join-Path $build 'package_staging'
if ([IO.Path]::GetFullPath($staging) -ne "$root\build\package_staging") { throw 'Unsafe staging path.' }
$version = '0.11.0'
$modName = 'ATS_Reverse_Trajectory_Predictor_1.61.scs'
$runtimeName = 'ATSReverseTrajectoryRuntime.dll'

if (-not (Test-Path -LiteralPath $MsBuild)) { throw "MSBuild was not found: $MsBuild" }

& $MsBuild (Join-Path $root 'src\entity_runtime\BuildProfileTests.vcxproj') /t:Rebuild /p:Configuration=Release /p:Platform=x64 /m:1 /v:minimal
if ($LASTEXITCODE -ne 0) { throw 'BuildProfileTests build failed.' }
& $MsBuild (Join-Path $root 'src\world_runtime\KinematicsTests.vcxproj') /t:Rebuild /p:Configuration=Release /p:Platform=x64 /m:1 /v:minimal
if ($LASTEXITCODE -ne 0) { throw 'KinematicsTests build failed.' }
& $MsBuild (Join-Path $root 'src\entity_runtime\ATSReverseTrajectoryRuntime.vcxproj') /t:Rebuild /p:Configuration=Release /p:Platform=x64 /m:1 /v:minimal
if ($LASTEXITCODE -ne 0) { throw 'ATS runtime build failed.' }

& (Join-Path $build 'entity_runtime_tests\BuildProfileTests.exe') `
    $AtsExecutable `
    '7C1A3CF292C1CCEDA28E4BCC1FCD285E04CCCD9A3105CAEE81E233388447CAD1'
if ($LASTEXITCODE -ne 0) { throw 'Installed ATS executable validation failed.' }
& (Join-Path $build 'world_runtime\KinematicsTests.exe')
if ($LASTEXITCODE -ne 0) { throw 'Reverse kinematics tests failed.' }

New-Item -ItemType Directory -Path $release -Force | Out-Null
$legacyRuntimePackage = Join-Path $release "ATS_Reverse_Trajectory_Predictor_v${version}_Runtime_Only.zip"
Remove-Item -LiteralPath $legacyRuntimePackage -Force -ErrorAction SilentlyContinue
if (Test-Path -LiteralPath $staging) { Remove-Item -LiteralPath $staging -Recurse -Force }
New-Item -ItemType Directory -Path $staging -Force | Out-Null

$temporaryModZip = Join-Path $release 'ats-mod-content.zip'
$modPath = Join-Path $release $modName
Remove-Item -LiteralPath $temporaryModZip,$modPath -Force -ErrorAction SilentlyContinue
& (Join-Path $PSScriptRoot 'PackageMod.ps1') -Destination $temporaryModZip
Move-Item -LiteralPath $temporaryModZip -Destination $modPath

function New-Package {
    param(
        [string]$Name,
        [ValidateSet('Full', 'Workshop')]
        [string]$PackageType
    )

    $includeMod = $PackageType -eq 'Full'

    $packageRoot = Join-Path $staging $Name
    New-Item -ItemType Directory -Path (Join-Path $packageRoot 'runtime'),(Join-Path $packageRoot 'installer') -Force | Out-Null
    Copy-Item -LiteralPath (Join-Path $build "entity_runtime\$runtimeName") -Destination (Join-Path $packageRoot 'runtime')
    Copy-Item -LiteralPath (Join-Path $root 'packaging\Install.ps1') -Destination (Join-Path $packageRoot 'installer')
    Copy-Item -LiteralPath (Join-Path $root 'README.md'),(Join-Path $root 'LICENSE') -Destination $packageRoot
    if ($includeMod) {
        New-Item -ItemType Directory -Path (Join-Path $packageRoot 'mod') -Force | Out-Null
        Copy-Item -LiteralPath $modPath -Destination (Join-Path $packageRoot 'mod')
        Copy-Item -LiteralPath (Join-Path $root 'packaging\Install-Full.bat') -Destination $packageRoot
    }
    else {
        Copy-Item -LiteralPath (Join-Path $root 'packaging\Install-Workshop.bat') -Destination $packageRoot
    }
    $zip = Join-Path $release "$Name.zip"
    Remove-Item -LiteralPath $zip -Force -ErrorAction SilentlyContinue
    Compress-Archive -Path (Join-Path $packageRoot '*') -DestinationPath $zip -CompressionLevel Optimal
}

New-Package "ATS_Reverse_Trajectory_Predictor_v${version}_Full" 'Full'
New-Package "ATS_Reverse_Trajectory_Predictor_v${version}_Workshop" 'Workshop'

Remove-Item -LiteralPath $staging -Recurse -Force
Get-ChildItem -LiteralPath $release -File | Select-Object Name, Length, LastWriteTime
