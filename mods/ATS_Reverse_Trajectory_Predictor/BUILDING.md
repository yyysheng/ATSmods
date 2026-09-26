# Building Reverse Posture Assistant For ATS 1.61.x

## Requirements

- Visual Studio 2026，Desktop development with C++，v145 toolset。
- Windows SDK。
- 仓库已包含构建所需的 SCS SDK 头文件和 MinHook 源码。

## 一键构建

在 PowerShell 中运行：

```powershell
.\tools\Build-Release.ps1
```

脚本会依次：

1. 构建并运行 BuildProfile 测试。
2. 构建并运行倒车运动学测试。
3. 构建 `ATSReverseTrajectoryRuntime.dll`。
4. 用本机 ATS 1.61.2.0 `amtrucks.exe` 验证精确哈希、4 个启用 Hook 和 4 个运行时辅助函数；测试还覆盖 ATS 1.61.1.1、1.60.1.8 与 1.60 签名回退。
5. 打包 `.scs`、完整安装包和运行时包。

## 兼容性原则

`src/entity_runtime/build_profiles.hpp` 保存 ATS 专用 Hook 与内部运行时 RVA。ATS 1.61.1.1 和 1.61.2.0 精确配置均校验全部 4 个启用 Hook 与 4 个运行时辅助函数；ATS 1.60 签名兼容回退只有在全部 4 个启用 Hook 完整匹配时才可用。未知构建或任一必需签名不匹配时，插件保留遥测注册，但不安装 MinHook。

添加新游戏构建时，必须重新验证所有启用 Hook 和 `RuntimeRvas`，不能直接沿用 ETS2 地址。
