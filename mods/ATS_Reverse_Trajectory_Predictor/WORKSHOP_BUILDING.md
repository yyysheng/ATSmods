# Steam Workshop package

The SCS Workshop Uploader expects this directory to contain only `versions.sii` and its version-package folders. Keep documentation outside `workshop/` so the uploader accepts the package root.

Before uploading:

1. Run `tools/Prepare-WorkshopPackages.ps1` to refresh the 1.60 and 1.61 content folders from `src/mod`.
2. Select the `workshop` directory in SCS Workshop Uploader.
3. Set the Workshop title to **美卡倒车轨迹预测 / ATS Reverse Trajectory Predictor**. This is the ATS item; the ETS2 “Reverse Posture Assistant” is a separate mod.
4. Use `assets/workshop_cover_640x360.jpg` as the preview image.
5. Copy `WORKSHOP_DESCRIPTION.txt` into the uploader's description field. It uses Steam Workshop BBCode, not Markdown.

The published item is available at [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3792042919).
