# ATS Reverse Trajectory Predictor

A world-space reverse posture and trajectory assistant for **American Truck Simulator 1.60** on Windows x64, with verified native build compatibility checks.

[Repository folder](https://github.com/yyysheng/ATSmods/tree/main/mods/ATS_Reverse_Trajectory_Predictor) | [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3792042919) | [Download v0.10.9](https://github.com/yyysheng/ATSmods/releases/tag/reverse-trajectory-predictor-v0.10.9)

When reverse gear is selected, the plug-in predicts tractor and trailer posture from SCS telemetry and displays collisionless lines directly in the game world. The lines follow steering and trailer articulation; they are not a screen overlay.

![ATS Reverse Trajectory Predictor](assets/workshop_cover.jpg)

## Features

- Two blue tractor boundaries and two orange trailer boundaries over a fixed 5 m prediction path.
- Wheel-contact-aware prediction for liftable and steerable axles and different wheelbases.
- Lines appear in reverse gear and hide outside reverse gear or while paused.
- World-space models visible through normal game rendering, including interior, exterior and mirror views.
- Game-owned trailer guide markers remain unchanged.
- Independent prediction models: no Reverse Assist Anchor or other cabin accessory installation is required.
- Exact-build and compatible-hook-layout profiles; native hooks are skipped if compatibility checks fail.
- No camera, mirror-image or depth-buffer capture; no bundled ReShade, `dxgi.dll` or `d3d11.dll`.

## Installation

Choose **one** resource source: Full standalone or Steam Workshop. Do not enable both copies.

### Full standalone package

1. Download [ATS_Reverse_Trajectory_Predictor_v0.10.9_Full.zip](https://github.com/yyysheng/ATSmods/releases/download/reverse-trajectory-predictor-v0.10.9/ATS_Reverse_Trajectory_Predictor_v0.10.9_Full.zip).
2. Fully exit ATS, extract the ZIP, and run `Install-Full.bat`.
3. Enable **美卡倒车轨迹预测** in the ATS Mod Manager, then restart the game.
4. Enter a driving session and select reverse gear. No cabin accessory is needed.

### Steam Workshop package

1. Subscribe to the [Steam Workshop item](https://steamcommunity.com/sharedfiles/filedetails/?id=3792042919) and let Steam download its content.
2. Download [ATS_Reverse_Trajectory_Predictor_v0.10.9_Workshop.zip](https://github.com/yyysheng/ATSmods/releases/download/reverse-trajectory-predictor-v0.10.9/ATS_Reverse_Trajectory_Predictor_v0.10.9_Workshop.zip).
3. Fully exit ATS, extract the ZIP, and run `Install-Workshop.bat`.
4. Enable the Workshop item in the Mod Manager, disable any standalone copy, then restart the game.

**A Workshop subscription cannot install the required DLL.** The Workshop package on GitHub supplies the runtime; Steam supplies the mod resources.

### Installer and updates

The installer copies `ATSReverseTrajectoryRuntime.dll` to `bin\win_x64` and also to `bin\win_x64\plugins` if that folder already exists. The Full package additionally installs the local `.scs` file; the Workshop package does not.

Success is shown in green; failure is shown in red. The installer does not modify `dxgi.dll` or `d3d11.dll`. When updating, exit ATS, update both resources and runtime DLL, and restart.

## Supported game version

- ATS 1.60, Windows x64; locally verified executable: **1.60.1.8**.
- Other builds require a matching enabled-hook layout. A mismatch disables native prediction rendering and leaves telemetry-only mode.
- ATS 1.61 and older branches such as 1.59 are not covered by this release.
- Automated build, compatibility and kinematics checks passed; in-game visual acceptance of v0.10.9 has not been performed.

## 中文说明

**美卡倒车轨迹预测**在游戏世界中显示两条蓝色车头边界和两条橙色挂车边界，固定预测沿倒车路径未来 5 米的扫掠范围。轨迹随方向盘和车头、挂车夹角变化，并考虑车轮接地、提升状态与可转向轴。

### 主要特点

- 蓝色车头与橙色挂车预测边界分别显示。
- 仅在倒挡时显示，非倒挡与暂停时隐藏。
- 使用无碰撞世界模型，保留游戏原生挂车提示标记。
- **不需要安装 Reverse Assist Anchor 或其他驾驶室挂件。**
- 不抓取摄像头、后视镜画面或深度缓冲，不依赖 ReShade。
- 不安装、不替换也不删除 `dxgi.dll` 或 `d3d11.dll`。

### 完整包安装

1. 下载上方 `Full.zip` 完整包。
2. 完全退出美卡，解压后运行 `Install-Full.bat`。
3. 在模组管理器启用“美卡倒车轨迹预测”，重新启动游戏。
4. 进入驾驶，挂入倒挡即可使用，无需购买或安装挂件。

### 创意工坊安装

1. 订阅上方创意工坊条目，等待 Steam 下载资源。
2. 下载上方 `Workshop.zip` 运行组件包。
3. 完全退出美卡，解压后运行 `Install-Workshop.bat`。
4. 在模组管理器启用工坊版、停用本地副本，再重新启动游戏。

**仅订阅工坊不能自动安装 DLL。** Full 包包含资源和 DLL；Workshop 包只安装 DLL，资源由 Steam 提供。两种方式选一种，不要同时启用本地版和工坊版。

安装成功显示绿色字符，失败显示红色字符。DLL 始终复制到 `bin\win_x64`；已有 `plugins` 子文件夹时，也会同步复制一份。升级时请同时更新资源与 DLL。

兼容范围为 ATS 1.60、Windows x64，本机已校验 1.60.1.8；其他构建必须通过原生 Hook 校验。本版不声明支持 1.61 或 1.59。自动化检查已通过，尚未完成 v0.10.9 的游戏内画面实测。

## Credits

- Project author: [yyysheng](https://github.com/yyysheng)
- Telemetry API: SCS SDK
- Hook library: MinHook

[Third-party notices](THIRD_PARTY_NOTICES.md) | [Build instructions](BUILDING.md) | [Verification](VERIFICATION_v0.10.9.md)
