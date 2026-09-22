# 美卡倒车轨迹预测 / ATS Reverse Trajectory Predictor v0.11.0

ATS 1.61.1.1 is now covered by an exact executable profile. The native runtime verifies its four enabled entry hooks and four required entity helpers before installation. The ATS 1.60.1.8 profile and compatible-hook-layout fallback remain available.

The Workshop version map contains separate 1.60 and 1.61 resource packages. Both the Full and Workshop runtime packages are provided below. Choose one mod source and do not enable standalone and Workshop copies together.

## Full package

1. Download `ATS_Reverse_Trajectory_Predictor_v0.11.0_Full.zip`.
2. Exit ATS, extract the ZIP, and run `Install-Full.bat`.
3. Enable the mod in the Mod Manager and restart the game.

## Workshop package

1. Subscribe to the Workshop item and wait for Steam to download the mod resources.
2. Download `ATS_Reverse_Trajectory_Predictor_v0.11.0_Workshop.zip`.
3. Exit ATS, extract the ZIP, and run `Install-Workshop.bat`.
4. Enable the Workshop item and restart the game.

The installer puts the runtime DLL in `bin\win_x64` and also in an existing `plugins` subfolder. Installation success is shown in green and failure in red. A Workshop subscription by itself does not install the runtime DLL.

## Compatibility and validation

- Exact local executable profiles: ATS 1.60.1.8 and ATS 1.61.1.1, Windows x64.
- ATS 1.60 builds may use the compatibility profile only when all enabled hook signatures match.
- Unknown executables or required-signature mismatches skip native hooks and retain telemetry-only mode.
- Build, profile/signature, and reverse-kinematics tests passed. In-game visual acceptance for v0.11.0 has not been performed.
