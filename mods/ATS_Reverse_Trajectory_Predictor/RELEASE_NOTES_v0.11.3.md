# Reverse Posture Assistant For ATS 1.61.x v0.11.3

## Update

- Road grade is fitted from grounded tyre centres reconstructed with per-wheel suspension travel. Unequal front/rear suspension height no longer introduces a false incline on level ground.
- Real road grade remains in the predicted path. A single-axle trailer uses the tractor tyre fit only for the direction its own wheel layout cannot determine.
- Adds an exact native profile for the local ATS 1.61.3.1 Steam package executable file version 1.61.3.18.
- Retains the ATS 1.61.1.1, 1.61.2.0, 1.61.3.1 and 1.60.1.8 profiles, plus the ATS 1.60 signature-compatible fallback.

## Installation

### Full standalone package

1. Download `Reverse_Posture_Assistant_For_ATS_v0.11.3_Full.zip` from this release.
2. Exit ATS, extract the ZIP, and run `Install-Full.bat`.
3. Enable **Reverse Posture Assistant For ATS 1.61.x** in the Mod Manager, then restart ATS.

### Steam Workshop package

1. Subscribe to the ATS Workshop item and let Steam download its resources.
2. Download `Reverse_Posture_Assistant_For_ATS_v0.11.3_Workshop.zip` from this release.
3. Exit ATS, extract the ZIP, and run `Install-Workshop.bat`.
4. Enable the Workshop mod and disable any standalone copy before restarting ATS.

The Workshop subscription provides mod resources but does not install the runtime DLL. Do not enable the Full and Workshop copies together.

## Compatibility

- ATS 1.61.3.1, including the local Steam executable file version 1.61.3.18, ATS 1.61.2.0 and ATS 1.61.1.1: exact Windows x64 profiles.
- ATS 1.60.1.8: exact Windows x64 profile. Other ATS 1.60 builds require matching enabled-hook signatures.
- Unknown or modified executables skip native hooks and retain telemetry-only mode.

This is an American Truck Simulator mod. It is separate from the ETS2 Reverse Posture Assistant.
