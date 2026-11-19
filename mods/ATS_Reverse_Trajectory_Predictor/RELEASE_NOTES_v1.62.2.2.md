# Reverse Posture Assistant For ATS V1.62.2.2

- Targets installed ATS 1.62.2.2 Windows x64, Steam Build 26761334.
- Starting here, the mod version matches its target game version. Historical v0.11.x versions retain their numbering and assets.
- Adds an exact executable profile, retaining all prior profiles.
- Ports early quit cleanup from ETS2: suspend rendering across pauses, release prediction models before the quit command starts engine teardown, and avoid native model destruction in telemetry shutdown.
- User confirmed trajectory rendering on the preceding adaptation. Exit cleanup in this build still requires an in-game recheck.
- Native compile, executable signature validation including the quit dispatcher, kinematics and licensing-package checks passed.
- Historical MIT grants and third-party notices are preserved. V1.62.2.2 activates proprietary terms for scheduled original code. Historical MIT grants and third-party licenses remain effective; assets are excluded.

从本版开始，模组版本号与适配的游戏版本号一致。本版为 V1.62.2.2。
已对照欧卡最新版移植退出前资源清理方案，退出修正仍待实机复测。工坊用户需同时更新资源和 GitHub DLL 组件包。
