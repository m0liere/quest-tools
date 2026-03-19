@echo off
title Quest Tools
cd /d "%~dp0"

echo.
echo  ✦  Quest Tools
echo  ─────────────────────────────────────
echo.

:: Check for Node.js
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo  [!] Node.js is not installed.
    echo      Download it from: https://nodejs.org
    echo.
    pause
    exit /b 1
)

:: Install dependencies if missing
if not exist node_modules (
    echo  Installing dependencies for the first time...
    echo  This takes a minute — only happens once.
    echo.
    npm install
    echo.
)

:: Open browser after a short delay (server needs a moment to start)
powershell -Command "Start-Sleep -Seconds 3; Start-Process 'http://localhost:4321'" >nul 2>nul &

echo  Starting server at http://localhost:4321
echo  Press Ctrl+C to stop.
echo.

npm run dev
