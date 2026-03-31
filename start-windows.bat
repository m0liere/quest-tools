@echo off
title Quest Tools
cd /d "%~dp0"

echo.
echo  ✦  Quest Tools
echo  ─────────────────────────────────────
echo.
echo  Welcome! This window is running the Quest Tools app on your computer.
echo  It acts as a local server that powers everything you see in your browser.
echo.
echo  Keep this window open while you're using the app.
echo  Closing it will stop the app from working.
echo.
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
echo  Your browser should open automatically in a few seconds.
echo.
echo  Press Ctrl+C to stop the app.
echo.

npm run dev
