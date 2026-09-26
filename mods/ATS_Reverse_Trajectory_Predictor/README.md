# 美卡倒车轨迹预测 / ATS Reverse Trajectory Predictor

An **American Truck Simulator only** reverse guidance mod for Windows x64. The current release is **v0.11.1**.

![ATS Reverse Trajectory Predictor Workshop cover](assets/workshop_cover.jpg)

[Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3792042919) · [Latest release](https://github.com/yyysheng/ATSmods/releases/tag/reverse-trajectory-predictor-v0.11.1) · [Source folder](https://github.com/yyysheng/ATSmods/tree/main/mods/ATS_Reverse_Trajectory_Predictor)

**Game scope:** This is the ATS mod **美卡倒车轨迹预测 / ATS Reverse Trajectory Predictor**. “Reverse Posture Assistant For ETS2 1.61.x” is a separate ETS2 mod and Workshop item.

When reverse gear is selected, the runtime predicts tractor and trailer posture from SCS telemetry and draws collisionless guide lines directly in the game world. The lines follow steering and trailer articulation; they are not a screen overlay.

## Features

- Two blue tractor boundaries and two orange trailer boundaries over a fixed 5 m prediction path.
- Wheel-contact-aware prediction for liftable and steerable axles and different wheelbases.
- Lines appear in reverse gear and hide outside reverse gear or while paused.
- World-space models use normal game rendering, including interior, exterior, and mirror views.
- The game's trailer guide markers remain unchanged.
- No cabin accessory is required.
- Native hooks run only on verified executable profiles. Unknown builds keep telemetry but skip native hooks.
- No camera, mirror-image, or depth-buffer capture. No bundled ReShade, `dxgi.dll`, or `d3d11.dll`.

## Installation

Choose **one** mod source: Full standalone or Steam Workshop. Do not enable both copies.

### Full standalone package

1. Download [ATS_Reverse_Trajectory_Predictor_v0.11.1_Full.zip](https://github.com/yyysheng/ATSmods/releases/download/reverse-trajectory-predictor-v0.11.1/ATS_Reverse_Trajectory_Predictor_v0.11.1_Full.zip).
2. Fully exit ATS, extract the ZIP, and run `Install-Full.bat`.
3. Enable **美卡倒车轨迹预测 / ATS Reverse Trajectory Predictor** in the ATS Mod Manager, then restart the game.
4. Enter a driving session and select reverse gear. No cabin accessory is needed.

### Steam Workshop package

1. Subscribe to the [ATS Workshop item](https://steamcommunity.com/sharedfiles/filedetails/?id=3792042919) and let Steam download its content.
2. Download [ATS_Reverse_Trajectory_Predictor_v0.11.1_Workshop.zip](https://github.com/yyysheng/ATSmods/releases/download/reverse-trajectory-predictor-v0.11.1/ATS_Reverse_Trajectory_Predictor_v0.11.1_Workshop.zip).
3. Fully exit ATS, extract the ZIP, and run `Install-Workshop.bat`.
4. Enable the Workshop item in the Mod Manager, disable any standalone copy, then restart ATS.

**A Workshop subscription does not install the required DLL.** Steam supplies the mod resources; the Workshop ZIP on GitHub installs the runtime. The Full package contains both.

The installer copies `ATSReverseTrajectoryRuntime.dll` to `bin\win_x64` and also to `bin\win_x64\plugins` if that folder already exists. Success is shown in green and failure in red. The installer does not modify `dxgi.dll` or `d3d11.dll`. When updating, exit ATS, update both resources and runtime, then restart.

## ATS compatibility

- **ATS 1.61.2.0**, Windows x64: exact executable profile, checked against the installed Steam executable. Its four entry hooks and four required entity helpers are checked before native hooks are enabled.
- **ATS 1.61.1.1**, Windows x64: retained exact executable profile with the same hook/helper checks.
- **ATS 1.60.1.8**, Windows x64: exact executable profile. Other ATS 1.60 builds require all enabled hook signatures to match.
- Other or modified executables skip native hooks and retain telemetry-only mode.
- Automated build/profile and kinematics checks are recorded in [v0.11.1 verification](VERIFICATION_v0.11.1.md). In-game visual acceptance of v0.11.1 has not been performed.

## 中文说明

**美卡倒车轨迹预测 / ATS Reverse Trajectory Predictor** 是仅适用于 American Truck Simulator 的模组，与欧卡 2 工坊中的 “Reverse Posture Assistant For ETS2 1.61.x” 是不同游戏、不同名称的独立条目。

倒挡时，模组根据 SCS 遥测在游戏世界中显示车头与挂车的预测扫掠边界：蓝色代表车头，橙色代表挂车，沿倒车路径预测固定 5 米。轨迹随方向盘和挂车夹角变化，并考虑车轮接地、提升状态与可转向轴。非倒挡或暂停时隐藏，保留游戏原生挂车提示标记。

### 安装

完整包与工坊版二选一，不要同时启用：

1. **本地完整包：**下载上方 `Full.zip`，完全退出美卡，解压后运行 `Install-Full.bat`。
2. 在模组管理器中启用“美卡倒车轨迹预测 / ATS Reverse Trajectory Predictor”，重新启动游戏。
3. **创意工坊：**订阅[美卡工坊条目](https://steamcommunity.com/sharedfiles/filedetails/?id=3792042919)，等待 Steam 下载资源；另行下载 `Workshop.zip` 并运行 `Install-Workshop.bat`。
4. 在模组管理器中启用工坊版、停用本地副本，再重新启动游戏。

仅订阅工坊不会自动安装 DLL。Steam 提供模组资源，GitHub 上的 Workshop 包安装运行组件；Full 完整包包含资源与运行组件。运行组件复制到 `bin\win_x64`，如果已有 `plugins` 子文件夹也会同步复制。成功显示绿色字符，失败显示红色字符。升级时请同时更新资源与 DLL。

无需安装 Reverse Assist Anchor 或其他驾驶室挂件。模组不抓取摄像头、后视镜画面或深度缓冲，不附带 ReShade、`dxgi.dll` 或 `d3d11.dll`。

### 美卡兼容版本

- **ATS 1.61.2.0**（Windows x64）：本机 Steam 可执行文件精确配置；启用原生 Hook 前检查 4 个入口 Hook 和 4 个必需实体辅助函数。
- **ATS 1.61.1.1**（Windows x64）：保留精确配置和相同的 Hook/辅助函数校验。
- **ATS 1.60.1.8**（Windows x64）：精确配置；其他 ATS 1.60 构建必须匹配全部已启用 Hook 签名。
- 其他或修改过的可执行文件会跳过原生 Hook，仅保留遥测模式。
- 自动构建、配置校验与运动学检查记录见 [v0.11.1 验证记录](VERIFICATION_v0.11.1.md)。尚未完成 v0.11.1 游戏内画面验收。

## Project information

- Author: [yyysheng](https://github.com/yyysheng)
- Telemetry API: SCS SDK
- Hook library: MinHook
- [Third-party notices](THIRD_PARTY_NOTICES.md) · [Build instructions](BUILDING.md) · [Workshop upload instructions](WORKSHOP_BUILDING.md)
