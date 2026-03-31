#!/bin/bash

# Change to the directory this script lives in
cd "$(dirname "$0")"

echo ""
echo " ✦  Quest Tools"
echo " ─────────────────────────────────────"
echo ""
echo " Welcome! This window is running the Quest Tools app on your computer."
echo " It acts as a local server that powers everything you see in your browser."
echo ""
echo " Keep this window open while you're using the app."
echo " Closing it will stop the app from working."
echo ""
echo " ─────────────────────────────────────"
echo ""

# Check for Node.js
if ! command -v node &> /dev/null; then
    echo " [!] Node.js is not installed."
    echo "     Download it from: https://nodejs.org"
    echo ""
    read -p " Press Enter to exit..."
    exit 1
fi

# Install dependencies if missing
if [ ! -d "node_modules" ]; then
    echo " Installing dependencies for the first time..."
    echo " This takes a minute — only happens once."
    echo ""
    npm install
    echo ""
fi

# Open browser after server has had time to start
(sleep 3 && open http://localhost:4321) &

echo " Starting server at http://localhost:4321"
echo " Your browser should open automatically in a few seconds."
echo ""
echo " Press Ctrl+C to stop the app."
echo ""

npm run dev
