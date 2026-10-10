# v0.11.2 build record (2026-10-10)

## Evidence and scope

The existing game log identifies ATS 1.61.3.1 and explicitly reports that v0.11.1 disabled native hooks for an unknown executable digest. Car mode publishes four-wheel geometry using the SDK truck configuration.

Executable SHA-256: 5D3B4E343154DE6B25DD366B6048C5BC5C452A4DAA50BC38B33FD2E571D54257.
New entry addresses were selected from signature matches and inspected using x64 disassembly. Native compatibility remains gated on the exact executable hash plus all four hook and four helper signatures.

| Function | RVA |
| --- | --- |
| model_load | 0x015db010 |
| vehicle_render_dispatch | 0x00799cc0 |
| trailer_visual_update | 0x00638ae0 |
| trailer_render | 0x00639250 |
| model_transfer | 0x0033df30 |
| model_parameter_init | 0x0041e040 |
| set_parent | 0x013cdd70 |
| set_transform | 0x013cde30 |

## Completed build checks

Release compilation succeeded with existing third-party MinHook warnings.
The already running release build completed BuildProfileTests, actual executable signature validation (4 hooks / 4 helpers), and KinematicsTests, including personal vehicle geometry and four-wheel tractor bounds.
Packaging requires ASCII installer text and rejects PowerShell parser errors.
Full and Workshop v0.11.2 packages were generated.

## Scope and user validation

The user clarified that this mod should support trucks and trailers only. The provisional
personal-vehicle geometry changes and their added test cases were removed. Prediction and
rendering now reject recognized Road Trip Ford/Dodge/Ram configurations. Existing truck
geometry is retained. Final scope-corrected runtime is compiled and repackaged; additional
tests and game visual review are not run, per the user's request.

On 2026-10-10 the user completed in-game validation of the installed truck-only v0.11.2 runtime and reported no abnormalities. This is user-reported acceptance; no additional agent game review was performed. New personal vehicle brands may require extending the identifier filter; vehicle id/brand are logged.

## Local installation

Windows PowerShell 5.1 executed the packaged Workshop installer successfully. Runtime copies in bin/win_x64 and bin/win_x64/plugins were updated. The existing local ATS_Reverse_Trajectory_Predictor_1.61.scs resource package was replaced while retaining its filename. Previous files are backed up under build/pre_v0.11.2_backup. The user subsequently completed in-game review without reported issues.
