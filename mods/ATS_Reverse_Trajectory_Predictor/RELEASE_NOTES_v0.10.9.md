# 美卡倒车轨迹预测 / ATS Reverse Trajectory Predictor v0.10.9

在游戏世界中显示蓝色车头与橙色挂车倒车扫掠边界，固定预测距离 5 米，随转向和挂车姿态实时更新。仅在倒挡时显示，保留游戏原生挂车提示标记。

**无需安装 Reverse Assist Anchor 或其他驾驶室挂件。**

## 安装

### Full 完整包

1. 下载下方 `ATS_Reverse_Trajectory_Predictor_v0.10.9_Full.zip`。
2. 完全退出 ATS，解压后运行 `Install-Full.bat`。
3. 在模组管理器启用“美卡倒车轨迹预测”，重新启动游戏。

### Workshop 运行组件包

1. 订阅[创意工坊模组](https://steamcommunity.com/sharedfiles/filedetails/?id=3792042919)，等待 Steam 下载资源。
2. 下载下方 `ATS_Reverse_Trajectory_Predictor_v0.10.9_Workshop.zip`。
3. 完全退出 ATS，解压后运行 `Install-Workshop.bat`。
4. 在模组管理器启用工坊版、停用本地副本，再重新启动游戏。

进入驾驶后挂入倒挡即可使用。仅订阅工坊不能安装必需的 DLL；升级时请同时更新资源与运行组件。不要同时启用本地版与工坊版。

安装成功显示绿色字符，失败显示红色字符。DLL 安装至 `bin\win_x64`，已有 `plugins` 子目录时也会同步复制。不会修改 `dxgi.dll` 或 `d3d11.dll`。

## English

World-space reverse guidance with blue tractor and orange trailer boundaries over a fixed 5 m path. **No Reverse Assist Anchor or other cabin accessory is required.**

- **Full:** exit ATS, extract the Full ZIP, run `Install-Full.bat`, enable the mod and restart.
- **Workshop:** subscribe to the linked item, exit ATS, extract the Workshop ZIP, run `Install-Workshop.bat`, enable the Workshop item and restart.

A Workshop subscription cannot install the DLL. Update both resources and runtime; do not enable standalone and Workshop copies together. Select reverse gear while driving to display prediction lines.

## 兼容范围 / Compatibility

ATS 1.60 / Windows x64; locally verified executable: **1.60.1.8**. Other builds must pass enabled-hook checks; mismatches disable native rendering and retain telemetry-only mode. ATS 1.61 and 1.59 are not covered.

构建、兼容性、运动学与隔离安装检查已通过；尚未完成 v0.10.9 的游戏内画面实测。

[源码与完整说明 / Source and documentation](https://github.com/yyysheng/ATSmods/tree/main/mods/ATS_Reverse_Trajectory_Predictor)
