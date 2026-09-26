param(
    [ValidateSet('Full', 'Workshop')]
    [string]$PackageType = 'Full',
    [switch]$VerifyOnly,
    [string]$GameRoot,
    [string]$ModDirectory
)

$ErrorActionPreference = 'Stop'
$packageRoot = Split-Path -Parent $PSScriptRoot
$runtimeName = 'ATSReverseTrajectoryRuntime.dll'
$modName = 'Reverse_Posture_Assistant_For_ATS_1.61.scs'
$isWorkshop = $PackageType -eq 'Workshop'

function Find-AtsGameRoot {
    $candidates = [System.Collections.Generic.List[string]]::new()
    $installKeys = @(
        'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 270880',
        'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 270880',
        'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 270880'
    )
    foreach ($key in $installKeys) {
        $location = (Get-ItemProperty -Path $key -ErrorAction SilentlyContinue).InstallLocation
        if ($location) { $candidates.Add($location) }
    }

    $steamPath = (Get-ItemProperty -Path 'HKCU:\Software\Valve\Steam' -ErrorAction SilentlyContinue).SteamPath
    if (-not $steamPath) { $steamPath = 'C:\Program Files (x86)\Steam' }
    $steamLibraries = [System.Collections.Generic.List[string]]::new()
    $steamLibraries.Add($steamPath)
    $libraryFile = Join-Path $steamPath 'steamapps\libraryfolders.vdf'
    if (Test-Path -LiteralPath $libraryFile) {
        foreach ($line in Get-Content -LiteralPath $libraryFile) {
            if ($line -match '"path"\s+"([^"]+)"') {
                $steamLibraries.Add($Matches[1].Replace('\\', '\'))
            }
        }
    }
    foreach ($library in $steamLibraries) {
        if (-not (Test-Path -LiteralPath $library -PathType Container -ErrorAction SilentlyContinue)) { continue }
        $candidates.Add((Join-Path $library 'steamapps\common\American Truck Simulator'))
    }

    foreach ($candidate in $candidates | Select-Object -Unique) {
        if (-not (Test-Path -LiteralPath $candidate -PathType Container -ErrorAction SilentlyContinue)) { continue }
        if (Test-Path -LiteralPath (Join-Path $candidate 'bin\win_x64\amtrucks.exe')) {
            return $candidate
        }
    }
    throw 'American Truck Simulator was not found in the registered Steam libraries.'
}

try {
    if (Get-Process -Name amtrucks -ErrorAction SilentlyContinue) {
        throw 'American Truck Simulator is running. Exit the game before installing.'
    }

    if (-not $GameRoot) { $GameRoot = Find-AtsGameRoot }
    $gameExecutable = Join-Path $GameRoot 'bin\win_x64\amtrucks.exe'
    if (-not (Test-Path -LiteralPath $gameExecutable)) {
        throw "ATS executable was not found: $gameExecutable"
    }

    $gameBin = Join-Path $GameRoot 'bin\win_x64'
    $pluginsDirectory = Join-Path $gameBin 'plugins'
    if (-not $ModDirectory) {
        $ModDirectory = Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'American Truck Simulator\mod'
    }

    $runtimeSource = Join-Path $packageRoot "runtime\$runtimeName"
    if (-not (Test-Path -LiteralPath $runtimeSource)) {
        throw "Runtime file is missing: $runtimeSource"
    }
    $modSource = Join-Path $packageRoot "mod\$modName"
    if (-not $isWorkshop -and -not (Test-Path -LiteralPath $modSource)) {
        throw "Mod file is missing: $modSource"
    }

    $runtimeTargets = [System.Collections.Generic.List[string]]::new()
    $runtimeTargets.Add((Join-Path $gameBin $runtimeName))
    if (Test-Path -LiteralPath $pluginsDirectory -PathType Container) {
        $runtimeTargets.Add((Join-Path $pluginsDirectory $runtimeName))
    }

    if ($VerifyOnly) {
        Write-Host ''
        Write-Host 'VERIFICATION SUCCESSFUL / 安装包验证成功' -ForegroundColor Green
        Write-Host "Package type: $PackageType"
        Write-Host "Game directory: $GameRoot"
        foreach ($target in $runtimeTargets) { Write-Host "DLL target: $target" }
        if (-not $isWorkshop) { Write-Host "Mod target: $(Join-Path $ModDirectory $modName)" }
        exit 0
    }

    foreach ($target in $runtimeTargets) {
        Copy-Item -LiteralPath $runtimeSource -Destination $target -Force
    }

    if (-not $isWorkshop) {
        New-Item -ItemType Directory -Path $ModDirectory -Force | Out-Null
        Copy-Item -LiteralPath $modSource -Destination (Join-Path $ModDirectory $modName) -Force
    }

    Write-Host ''
    Write-Host 'INSTALLATION SUCCESSFUL / 安装成功' -ForegroundColor Green
    Write-Host 'Reverse Posture Assistant For ATS 1.61.x v0.11.1' -ForegroundColor Green
    Write-Host "Package type: $PackageType"
    Write-Host "Game directory: $GameRoot"
    foreach ($target in $runtimeTargets) { Write-Host "Installed DLL: $target" }
    if (-not $isWorkshop) {
        Write-Host "Installed mod: $(Join-Path $ModDirectory $modName)"
        Write-Host 'Enable the 美卡倒车轨迹预测 mod in the ATS Mod Manager before driving.'
    }
    else {
        Write-Host 'Subscribe to and enable the Workshop mod before driving.'
    }
    Write-Host 'dxgi.dll and d3d11.dll were not modified.'
    exit 0
}
catch {
    Write-Host ''
    Write-Host 'INSTALLATION FAILED / 安装失败' -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host 'No further installation steps were performed.' -ForegroundColor Red
    exit 1
}
