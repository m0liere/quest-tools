@echo off
title Quest Tools - Update
cd /d "%~dp0"

echo.
echo  ✦  Quest Tools — Update
echo  ─────────────────────────────────────
echo.

:: ── Path A: already a git repo ─────────────────────────────────────────────
if exist ".git" (
    echo  Git repository detected. Pulling latest changes...
    echo.

    where git >nul 2>nul
    if %errorlevel% neq 0 (
        echo  [!] git is not installed.
        echo      Download it from: https://git-scm.com
        echo.
        pause
        exit /b 1
    )

    git pull
    echo.
    echo  Installing any new dependencies...
    npm install
    echo.
    echo  ✓ Update complete! Restart the app to use the latest version.
    echo.
    pause
    exit /b 0
)

:: ── Path B: downloaded as a zip (no .git folder) ───────────────────────────
echo  This folder was not cloned from GitHub.
echo  You have two options to get updates:
echo.
echo    Option 1 — Re-download the zip from GitHub:
echo    https://github.com/m0liere/quest-tools/releases/latest
echo    Then replace all files EXCEPT db.json (that's your data).
echo.
echo    Option 2 — Use the GitHub CLI for automatic updates:
echo.

where gh >nul 2>nul
if %errorlevel% neq 0 (
    echo    The GitHub CLI is not installed.
    echo    To install it, visit: https://cli.github.com
    echo    Then run this script again.
    echo.
    pause
    exit /b 0
)

echo    GitHub CLI found. Setting up automatic updates...
echo.

:: Log in if needed
gh auth status >nul 2>nul
if %errorlevel% neq 0 (
    echo  Logging in to GitHub (a browser window will open)...
    gh auth login
    echo.
)

echo  Downloading the latest version...
echo  (Your data in db.json will be preserved.)
echo.

set TMPDIR=%TEMP%\ql-update
if exist "%TMPDIR%" rmdir /s /q "%TMPDIR%"
mkdir "%TMPDIR%"

gh repo clone m0liere/quest-tools "%TMPDIR%\repo" -- --depth=1
if %errorlevel% neq 0 (
    echo  [!] Could not reach the repository.
    echo      Make sure you're connected to the internet and try again.
    rmdir /s /q "%TMPDIR%"
    pause
    exit /b 1
)

:: Copy files, preserving db.json and node_modules
robocopy "%TMPDIR%\repo" "." /E /XF db.json /XD node_modules .git /NFL /NDL /NJH /NJS

rmdir /s /q "%TMPDIR%"

echo.
echo  Installing any new dependencies...
npm install

echo.
echo  ✓ Update complete! Restart the app to use the latest version.
echo.
pause
