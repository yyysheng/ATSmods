@echo off
chcp 65001 >nul
title Reverse Posture Assistant For ATS 1.61.x v0.11.1 - Full Installer
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0installer\Install.ps1" -PackageType Full
set "INSTALL_EXIT=%ERRORLEVEL%"
echo.
pause
exit /b %INSTALL_EXIT%
