#!/bin/bash

cd "$(dirname "$0")"

echo ""
echo " ✦  Quest Tools — Update"
echo " ─────────────────────────────────────"
echo ""

# ── Path A: already a git repo ─────────────────────────────────────────────
if [ -d ".git" ]; then
    echo " Git repository detected. Pulling latest changes..."
    echo ""

    if ! command -v git &> /dev/null; then
        echo " [!] git is not installed."
        echo "     Download it from: https://git-scm.com"
        echo ""
        read -p " Press Enter to exit..."
        exit 1
    fi

    git pull
    echo ""
    echo " Installing any new dependencies..."
    npm install
    echo ""
    echo " ✓ Update complete! Restart the app to use the latest version."
    echo ""
    read -p " Press Enter to close..."
    exit 0
fi

# ── Path B: downloaded as a zip (no .git folder) ───────────────────────────
echo " This folder was not cloned from GitHub."
echo " You have two options to get updates:"
echo ""
echo "   Option 1 — Re-download the zip from GitHub:"
echo "   https://github.com/m0liere/quest-tools/releases/latest"
echo "   Then replace all files EXCEPT db.json (that's your data)."
echo ""
echo "   Option 2 — Use the GitHub CLI for automatic updates:"
echo ""

if ! command -v gh &> /dev/null; then
    echo "   The GitHub CLI is not installed."
    echo "   To install it:"
    echo ""
    echo "   1. Go to: https://cli.github.com"
    echo "   2. Download the installer for Mac (.pkg file)"
    echo "   3. Open the downloaded file and follow the prompts"
    echo "   4. Run this update script again"
    echo ""
    read -p " Press Enter to exit..."
    exit 0
fi

echo "   GitHub CLI found. Setting up automatic updates..."
echo ""

# Log in if needed
if ! gh auth status &> /dev/null; then
    echo " Logging in to GitHub (a browser window will open)..."
    gh auth login
    echo ""
fi

echo " Downloading the latest version..."
echo " (Your data in db.json will be preserved.)"
echo ""

TMPDIR_QL=$(mktemp -d)
gh repo clone m0liere/quest-tools "$TMPDIR_QL/repo" -- --depth=1 2>/dev/null

if [ $? -ne 0 ]; then
    echo " [!] Could not reach the repository."
    echo "     Make sure you're connected to the internet and try again."
    rm -rf "$TMPDIR_QL"
    read -p " Press Enter to exit..."
    exit 1
fi

# Copy files, preserving db.json and node_modules
rsync -av \
    --exclude='db.json' \
    --exclude='node_modules' \
    --exclude='.git' \
    "$TMPDIR_QL/repo/" ./

rm -rf "$TMPDIR_QL"

echo ""
echo " Installing any new dependencies..."
npm install

echo ""
echo " ✓ Update complete! Restart the app to use the latest version."
echo ""
read -p " Press Enter to close..."
