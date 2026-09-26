# v0.11.1 verification (2026-09-26)

- Added a hash-pinned ATS 1.61.2.0 Steam public executable profile while retaining the exact ATS 1.61.1.1 and ATS 1.60.1.8 profiles and the 1.60 signature-compatible fallback.
- Local ATS executable: `1.61.2.0 (6949e633e77902f7e023819d3131cc6ccce3707f)`; SHA-256: `9DF9745ABEE9C698919B572A1E6C645C00E4F37218A90498589C0101A391740C`.
- Matched four entry-hook signatures at RVAs `0x015dacf0`, `0x00799b20`, `0x00638a20` and `0x00639190`.
- Matched four runtime-helper signatures at RVAs `0x0033de80`, `0x0041df90`, `0x013cda50` and `0x013cdb10`.
- Unknown executable hashes or any required signature mismatch skip native hook installation and keep telemetry-only mode.
- BuildProfileTests passed for the exact ATS 1.60.1.8, 1.61.1.1 and 1.61.2.0 profiles, the ATS 1.60 signature fallback, and hook/helper mismatch rejection.
- The installed ATS 1.61.2.0 executable passed exact SHA-256 and signature validation: 4/4 enabled hooks and 4/4 required runtime helpers.
- KinematicsTests passed (26 prediction boxes; wheelbase cases 3.8 m and 5.46667 m).
- Release build generated the v0.11.1 Full and Workshop ZIPs and the English-title `.scs` mod package. The Full ZIP carries the `.scs` and runtime; the Workshop ZIP carries the runtime installer.
- The Workshop uploader tree contains separate v0.11.1 ATS 1.60 and 1.61 resource packages.
- In-game visual acceptance has not been performed and is not claimed.
