# Reverse Posture Assistant For ATS 1.61.x v0.11.2

Adds an exact runtime profile for ATS 1.61.3.1 and fixes Windows PowerShell 5.1 installer parsing errors caused by text encoding. All four entry hooks and four required entity helpers are checked before native hooks are enabled.

This mod supports truck tractors and trailers only. Personal vehicle mode does not display reverse lines. Truck geometry remains unchanged; unavailable telemetry samples are cleared when switching modes.

## Full package

1. Download `Reverse_Posture_Assistant_For_ATS_v0.11.2_Full.zip` from the release assets.
2. Exit ATS, extract the ZIP, and run `Install-Full.bat`.
3. Enable **Reverse Posture Assistant For ATS 1.61.x** in the Mod Manager and restart ATS.

## Workshop package

1. Subscribe to the [ATS Workshop item](https://steamcommunity.com/sharedfiles/filedetails/?id=3792042919) and let Steam download its resources.
2. Download `Reverse_Posture_Assistant_For_ATS_v0.11.2_Workshop.zip` from the release assets.
3. Exit ATS, extract the ZIP, and run `Install-Workshop.bat`.
4. Enable the Workshop item and disable any standalone copy before restarting ATS.

Steam supplies Workshop resources, but the Workshop subscription does not install the runtime DLL. The installer copies the DLL to `bin\win_x64` and also to an existing `plugins` subfolder. Choose either Full or Workshop resources, not both.

## Compatibility

- ATS 1.61.3.1, 1.61.2.0 and 1.61.1.1: exact Windows x64 profiles with four entry-hook and four entity-helper checks.
- ATS 1.60.1.8: exact Windows x64 profile; other 1.60 builds require matching enabled-hook signatures.
- Unknown or modified executables: telemetry-only mode.
- Truck and trailer support only; personal vehicle mode is intentionally excluded.
- On 2026-10-10 the user completed v0.11.2 in-game validation and reported no abnormalities.

[Source and documentation](https://github.com/yyysheng/ATSmods/tree/main/mods/ATS_Reverse_Trajectory_Predictor) · [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3792042919)
