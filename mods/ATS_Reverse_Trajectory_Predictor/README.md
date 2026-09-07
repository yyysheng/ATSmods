# ATS Reverse Trajectory Predictor

A world-space reverse posture and trajectory assistant for the exact **American Truck Simulator 1.60.1.8** Windows x64 build.

[Repository folder](https://github.com/yyysheng/ATSmods/tree/main/mods/ATS_Reverse_Trajectory_Predictor) | [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3792042919) | [GitHub release v0.10.9](https://github.com/yyysheng/ATSmods/releases/tag/reverse-trajectory-predictor-v0.10.9)

When reverse gear is selected, the plug-in predicts tractor and trailer posture from official telemetry and creates collisionless frame models directly in the game world. The frames are normal Prism3D entities, so every game camera can see the same objects. No camera feed, render pass, depth buffer, constant buffer, or post-process overlay is read or modified.

![ATS Reverse Trajectory Predictor](assets/workshop_cover.jpg)

## Features

- Live tractor reverse trajectory.
- Trailer articulation and future posture prediction.
- Separate blue tractor and orange trailer swept-area boundaries over a fixed 5 m path.
- Ground-contact-aware virtual axles for liftable and steerable tractor/trailer axles.
- Collisionless low-profile line entities placed on the predicted ground path.
- Automatic display only while reverse gear is selected.
- Visible through normal game rendering from exterior, interior, free, and mirror views.
- Accessory anchors for 19 stock ATS 1.60 trucks.
- Exact executable hash and native signature checks; unsupported builds fail closed.
- No ReShade, `dxgi.dll`, `d3d11.dll`, or graphics API dependency.

## Installation

### Full standalone package

1. Download [`ATS_Reverse_Trajectory_Predictor_v0.10.9_Full.zip`](https://github.com/yyysheng/ATSmods/releases/download/reverse-trajectory-predictor-v0.10.9/ATS_Reverse_Trajectory_Predictor_v0.10.9_Full.zip).
2. Exit ATS, extract the package, and run `Install-Full.bat`.
3. Enable **美卡倒车轨迹预测** in the ATS Mod Manager.
4. Install `Reverse Assist Anchor` in a cabin accessory slot. The anchor itself is invisible.

### Steam Workshop package

1. Subscribe to the [Steam Workshop item](https://steamcommunity.com/sharedfiles/filedetails/?id=3792042919).
2. Download [`ATS_Reverse_Trajectory_Predictor_v0.10.9_Workshop.zip`](https://github.com/yyysheng/ATSmods/releases/download/reverse-trajectory-predictor-v0.10.9/ATS_Reverse_Trajectory_Predictor_v0.10.9_Workshop.zip).
3. Exit ATS, extract the package, and run `Install-Workshop.bat`.
4. Enable **美卡倒车轨迹预测** in the ATS Mod Manager and install `Reverse Assist Anchor` in a cabin accessory slot.

Steam Workshop cannot install the required telemetry plug-in into the game directory, so the GitHub Workshop package is required. The installer places the DLL in `bin\win_x64` and also copies it to `bin\win_x64\plugins` when that folder exists.

## Supported game version

When updating, exit ATS and update both the mod resources and runtime DLL, then restart the game. Do not enable the standalone and Workshop copies together. Game-owned trailer markers remain unchanged. ATS 1.61 is not verified.

更新时请退出游戏，同时更新模组资源与运行时 DLL，再重新启动。不要同时启用本地版与工坊版。保留游戏原生挂车提示标记；尚未验证 ATS 1.61。

- American Truck Simulator `1.60.1.8`
- Windows x64

## 中文说明

**美卡倒车轨迹预测**严格适用于 American Truck Simulator 1.60.1.8。挂入倒挡后，它根据 SCS 官方遥测数据计算车头与挂车的未来姿态，并在游戏世界中创建无碰撞的低矮实体框线。

主要特点：

- 实时预测车头和挂车倒车轨迹。
- 蓝色车头扫掠边界与橙色挂车扫掠边界分开显示，固定预测 5 米。
- 根据车轴实际接地和转向状态适配提升桥、随动桥以及不同轴距车型。
- 支持 19 款 ATS 1.60 原版卡车。
- 仅在倒挡时显示，不读取摄像头、后视镜、渲染过程或图形缓冲。
- 框线是 Prism3D 世界实体，各种正常视角看到的是同一组对象。
- 模型不含碰撞，不参与车辆碰撞。
- 不安装、不替换也不删除 `dxgi.dll` 或 `d3d11.dll`。

完整安装请下载 Release 中的 `Full` 包；通过 Steam 创意工坊订阅时，还需要下载 `Workshop` 包安装运行时 DLL。安装器始终把 DLL 安装到 `bin\win_x64`；如果已经存在 `bin\win_x64\plugins` 文件夹，也会同步复制一份。

## Credits

- Project author: [yyysheng](https://github.com/yyysheng)
- Telemetry API: SCS SDK
- Hook library: MinHook

See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for license details. Source build instructions are available in [BUILDING.md](BUILDING.md).
