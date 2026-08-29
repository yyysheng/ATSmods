# Verification — ATS Reverse Trajectory Predictor v0.10.8

验证日期：2026-08-29

## 目标游戏

- Executable: `amtrucks.exe`
- Version: `1.60.1.8 (26c95e307fd5da6a42e0ad6801809dcd9eee4f17)`
- SHA-256: `3C702A9F1CADAA8756EAB68B7BAAC70460F8019434B51B877AFBE0FEAD68C7D2`

## ETS2 → ATS Prism3D RVA 映射

同一引擎提交的 ETS2 1.60.1.7 与 ATS 1.60.1.8 可执行文件逐函数比较；下列目标函数均以 16–96 字节连续函数体签名得到唯一 ATS 命中。

| Symbol | ATS RVA |
|---|---:|
| model_load | `0x01518E70` |
| model_activate | `0x01529250` |
| model_transfer | `0x0032D970` |
| model_parameter_init | `0x0040D650` |
| vehicle_accessory_collect | `0x006490C0` |
| vehicle_addon_finalize | `0x00649900` |
| render_entry_populate | `0x00312560` |
| final_base_model_create | `0x01517E50` |
| final_model_create | `0x01517DA0` |
| final_accessory_insert | `0x005381C0` |
| set_parent | `0x01315340` |
| set_transform | `0x01315400` |
| vehicle_render_dispatch | `0x00772AA0` |
| trailer_visual_update | `0x00614C10` |
| trailer_render | `0x00615370` |

返回点同时映射为 `0x00649CB0`、`0x0064AA5C`、`0x0064B011`。

## 自动测试

- `BuildProfileTests.exe`: PASS
  - 精确 SHA-256 配置匹配。
  - 4/4 启用 Hook 签名匹配。
  - 签名兼容回退匹配。
  - 任一启用 Hook 改变时拒绝并安全降级。
- `KinematicsTests.exe`: PASS
  - 26 个预测框。
  - 最大步进限制：`0.327526`, `0.256002`。
  - 自适应轴距：`3.8`, `5.46667`。
- Runtime build: PASS, Windows x64 DLL。
- DLL exports: `scs_telemetry_init`, `scs_telemetry_shutdown`。
- Full installer: PASS；已有 `plugins` 时同时写入 `bin\win_x64` 和 `bin\win_x64\plugins`，并安装 `.scs`，退出码 0。
- Workshop installer: PASS；无 `plugins` 时只写入 `bin\win_x64`，不创建插件子目录、不安装 `.scs`，退出码 0。
- Installer failure path: PASS；缺少运行时文件时显示红色失败提示并返回退出码 1。
- Installer encoding: PASS；UTF-8 BOM，在 Windows PowerShell 5.1 下中文提示可解析。
- `.scs` archive inspection: PASS，根目录含 `manifest.sii`、资源模型、材质和 19 个卡车锚点定义。

## 最终产物 SHA-256

- `ATSReverseTrajectoryRuntime.dll`: `B6D4A2AD3A7AD3FB648D1B71E2446B28CB71C7F25BB462AE978FDE526301ACFA`
- `ATS_Reverse_Trajectory_Predictor_1.60.scs`: `4AF240883C47496A34D8BA29930791D9C69122632AF39463A57F7D36ABEE7486`
- `ATS_Reverse_Trajectory_Predictor_v0.10.8_Full.zip`: `BE4CA81BB221E93D2F94D6EB565A8A375EB3CFD461A3ACCADE34A4102189D244`
- `ATS_Reverse_Trajectory_Predictor_v0.10.8_Workshop.zip`: `554E0BB8260DF2403662420187A0BDD63DFC2559FC7DD9EDB98C8296C393317C`

## 边界

已完成构建、二进制映射、签名、运动学、归档结构以及 Full/Workshop 安装成功和失败分支的自动验证。安装包测试全部使用隔离目录，没有改动存档或自动启动游戏；首次实际驾驶验证仍应观察 `ATSReverseTrajectoryRuntime.log` 中的 BuildProfile、4/4 Hook 和 prediction models 日志。
