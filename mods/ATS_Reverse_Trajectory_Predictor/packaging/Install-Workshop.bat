@echo off
chcp 65001 >nul
title ATS Reverse Trajectory Predictor v0.10.8 - Workshop Installer
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0installer\Install.ps1" -PackageType Workshop
set "INSTALL_EXIT=%ERRORLEVEL%"
echo.
pause
exit /b %INSTALL_EXIT%
