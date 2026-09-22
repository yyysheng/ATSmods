# v0.11.0 verification (2026-09-22)

- Added an exact ATS 1.61.1.1 Steam public executable profile while preserving the exact ATS 1.60.1.8 profile and 1.60 signature-compatible fallback.
- Matched and validated four ATS 1.61 entry hook signatures and four required entity-helper signatures against the installed game executable; unknown or mismatched profiles fail closed to telemetry-only mode.
- BuildProfileTests passed exact 1.60/1.61 selection, 1.60 fallback, unsupported executable rejection, and required hook/helper mismatch rejection.
- Installed ATS 1.61.1.1 executable passed exact SHA-256 and signature validation.
- The local ATS installation initially contained a 0.10.8 mod archive. Installed the verified v0.11.0 Full package; its SCS manifest confirms version 0.11.0 and ATS 1.60/1.61 compatibility, and both game-root and existing `plugins` DLL copies match the packaged runtime. The replaced 0.10.8 mod and prior plugin DLL were retained as `.bak` files.
- KinematicsTests passed.
- Full and Workshop packages include the v0.11.0 runtime installer; the Full package additionally carries the ATS 1.61 `.scs` package. Installer behavior copies the runtime to `bin\win_x64` and, when present, `plugins`.
- The Workshop version map contains separate ATS 1.60 and 1.61 content folders.
- Game-in-session visual acceptance has not been performed and is not claimed.
