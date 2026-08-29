@echo off
chcp 65001 >nul
title ATS Reverse Trajectory Predictor v0.10.8 - Full Installer
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0installer\Install.ps1" -PackageType Full
set "INSTALL_EXIT=%ERRORLEVEL%"
echo.
pause
exit /b %INSTALL_EXIT%
