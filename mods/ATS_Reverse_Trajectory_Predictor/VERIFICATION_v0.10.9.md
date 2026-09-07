# v0.10.9 verification (2026-09-07)

- Synchronized relevant maintenance from ETS2mods commit `111eb1028fa56c5992ba5d2853d7a394699c6646`.
- Preserved ATS-specific build profiles and runtime RVAs.
- Release rebuild passed (third-party MinHook warnings remain).
- BuildProfileTests passed exact/compatible selection and required-hook mismatch rejection against installed ATS 1.60.1.8.
- KinematicsTests passed.
- Full and Workshop installers tested in isolated directories: both runtime destinations match source hashes; Workshop does not install local resources; missing game returns exit code 1.
- Success/failure branches retain Green/Red console output.
- PackageMod rejects game-owned symbol overrides and native-marker mutation identifiers; validates required custom models and forward-slash archive paths.
- This ATS source already contained no loading.pmd/pmg override; its obsolete generator and runtime marker mutation were removed.
- In-game visual acceptance is not claimed. ATS 1.61 is not verified.
