#!/bin/bash

# Change to the directory this script lives in
cd "$(dirname "$0")"

echo ""
echo " ✦  Quest Tools"
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
echo " Press Ctrl+C to stop."
echo ""

npm run dev
