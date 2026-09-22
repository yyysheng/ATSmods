# Steam Workshop package

The SCS Workshop Uploader expects this directory to contain only `versions.sii` and its version-package folders. Keep documentation outside `workshop/` so the uploader accepts the package root.

Before uploading:

1. Run `tools/Prepare-WorkshopPackages.ps1` to refresh the 1.60 and 1.61 content folders from `src/mod`.
2. Select the `workshop` directory in SCS Workshop Uploader.
3. Use `assets/workshop_cover_640x360.jpg` as the preview image.
4. Copy `WORKSHOP_DESCRIPTION.txt` into the uploader's description field.

The published item is available at [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3792042919).
