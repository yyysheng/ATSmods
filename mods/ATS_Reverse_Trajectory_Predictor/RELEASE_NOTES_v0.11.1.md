# Reverse Posture Assistant For ATS 1.61.x v0.11.1

Adds an exact runtime profile for the current ATS 1.61.2.0 Steam executable. The profile checks all four enabled entry hooks and four required entity helpers before native hooks are installed.

The exact ATS 1.61.1.1 and 1.60.1.8 profiles remain available. Other ATS 1.60 builds can use the signature-compatible fallback only when all enabled hook signatures match. Unknown builds skip native hooks and retain telemetry-only mode.

## Full package

1. Download `Reverse_Posture_Assistant_For_ATS_v0.11.1_Full.zip` from the release assets.
2. Exit ATS, extract the ZIP, and run `Install-Full.bat`.
3. Enable **Reverse Posture Assistant For ATS 1.61.x** in the Mod Manager and restart ATS.

## Workshop package

1. Subscribe to the [ATS Workshop item](https://steamcommunity.com/sharedfiles/filedetails/?id=3792042919) and let Steam download its resources.
2. Download `Reverse_Posture_Assistant_For_ATS_v0.11.1_Workshop.zip` from the release assets.
3. Exit ATS, extract the ZIP, and run `Install-Workshop.bat`.
4. Enable the Workshop item and disable any standalone copy before restarting ATS.

Steam supplies Workshop resources, but the Workshop subscription does not install the runtime DLL. The installer copies the DLL to `bin\win_x64` and also to an existing `plugins` subfolder. Choose either Full or Workshop resources, not both.

## Compatibility

- ATS 1.60.1.8: exact Windows x64 profile; other 1.60 builds require matching enabled-hook signatures.
- ATS 1.61.1.1 and 1.61.2.0: exact Windows x64 profiles, each with four entry-hook and four entity-helper checks.
- Unknown or modified executables: telemetry-only mode.
- In-game visual acceptance of v0.11.1 has not been performed.

[Source and documentation](https://github.com/yyysheng/ATSmods/tree/main/mods/ATS_Reverse_Trajectory_Predictor) · [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3792042919)
