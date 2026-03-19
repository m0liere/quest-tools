# Quest Tools

A personal toolkit for tracking quests, energy, and growth — built by Quest Labs.

Includes: Quest Card, Wheel of Life, FRESH Check-in, and Questor Profile.

---

## Quick Start

### Step 1 — Download

1. Go to **[github.com/m0liere/quest-tools](https://github.com/m0liere/quest-tools)**
2. Click the green **Code** button near the top right
3. Click **Download ZIP**
4. Unzip the downloaded file anywhere on your computer

### Step 2 — Install Node.js (one-time)

Quest Tools runs on Node.js. If you don't have it:

- Download from **[nodejs.org](https://nodejs.org)** — get the LTS version
- Run the installer and follow the prompts

### Step 3 — Start the app

| System  | What to do |
|---------|-----------|
| **Mac** | Double-click `start-mac.command` |
| **Windows** | Double-click `start-windows.bat` |

The first launch installs dependencies (takes about a minute). After that it opens automatically at **http://localhost:4321**.

> **To stop the app:** go back to the terminal window and press `Ctrl+C`.

---

## Updating

Your data lives in `db.json` inside the Quest Tools folder — it is **never overwritten** by an update.

### Quick update path

1. Double-click `update-mac.command` (Mac) or `update-windows.bat` (Windows)
2. If you cloned the repo with git, it pulls the latest automatically
3. Restart the app

You can also click **↻ Updates** inside the app at any time for instructions.

### Setting up GitHub for automatic updates

If you downloaded the zip (not via git clone), do this once to enable one-click updates:

1. **Create a GitHub account** — [github.com](https://github.com) (free)
2. **Install the GitHub CLI** — go to [cli.github.com](https://cli.github.com), download the installer for your OS, and run it (it installs like any normal app — no technical steps required)
3. **Run the update script** — it will open a browser to log you in, then download the latest version automatically

After that, future updates are a single double-click.

---

## Your data

All your data (quest cards, wheel check-ins, profile, XP) is stored locally in `db.json` in the Quest Tools folder. Nothing is sent to any server. Back it up anytime using the **↓ Export** button inside the app.

---

## Troubleshooting

**"cannot be opened because the developer cannot be verified" (Mac)**
Right-click the `.command` file → Open → click Open in the dialog.

**The app won't start**
Make sure Node.js is installed (`node --version` in Terminal should print a version number). If `node_modules` is missing or broken, delete the folder and restart the app — it will reinstall.

**Port 4321 is already in use**
Another instance may already be running. Check your open terminal windows and stop any existing instance with `Ctrl+C`.
