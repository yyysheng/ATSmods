# 美卡倒车轨迹预测 / ATS Reverse Trajectory Predictor v0.10.9

根据车辆遥测，在倒挡时显示蓝色车头与橙色挂车扫掠边界，预测距离 5 米。支持 19 款原版 ATS 卡车，保留游戏原生挂车提示标记。

## 安装 / Installation

- **Full**：退出 ATS，解压完整包，运行 `Install-Full.bat`，启用模组并安装 `Reverse Assist Anchor` 驾驶室挂件。
- **Workshop**：订阅并启用[创意工坊模组](https://steamcommunity.com/sharedfiles/filedetails/?id=3792042919)，退出 ATS，解压 Workshop 包并运行 `Install-Workshop.bat`，安装上述挂件。

更新时需要同时更新模组资源与 DLL，再重启游戏。不要同时启用本地版和工坊版。安装成功显示绿色，失败显示红色；DLL 安装至 `bin\win_x64`，已有 `plugins` 子目录时也会同步复制。不会修改 `dxgi.dll` 或 `d3d11.dll`。

Exit ATS before installation. Update both resources and runtime DLL, then restart. Do not enable standalone and Workshop copies simultaneously. Steam Workshop requires the separate runtime installer.

Verified executable: ATS **1.60.1.8 / Windows x64**. Other builds must pass all enabled-hook checks; unsupported builds disable native rendering. ATS 1.61 is not verified. In-game visual acceptance of this release has not been performed.
