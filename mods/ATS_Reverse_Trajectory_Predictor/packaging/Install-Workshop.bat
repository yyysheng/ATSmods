@echo off
chcp 65001 >nul
title Reverse Posture Assistant For ATS 1.62.x v1.62.2.2 - Workshop Installer
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0installer\Install.ps1" -PackageType Workshop
set "INSTALL_EXIT=%ERRORLEVEL%"
echo.
pause
exit /b %INSTALL_EXIT%
