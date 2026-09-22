# Steam Workshop package

This directory contains the SCS Workshop Uploader version map and its universal informational fallback package.

The generated `160_content` and `161_content` packages are intentionally excluded from Git because they duplicate `src/mod`. Before uploading:

1. Copy `src/mod` to both `workshop/160_content` and `workshop/161_content`.
2. In each copied `manifest.sii`, update `package_version` to `0.11.0` and remove `display_name` and `compatible_versions`; Workshop obtains those values from the uploader and `versions.sii`.
3. Select this `workshop` directory in SCS Workshop Uploader.
4. Use `../assets/workshop_cover_640x360.jpg` as the preview image.

The published item is available at [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3792042919).
