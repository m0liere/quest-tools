# Quest Tools — Data Structure

`db.json` (project root) is the single source of truth for all user data. The dev server reads and writes it via API endpoints — no manual editing required during normal use.

---

## Top-Level Shape

```json
{
  "_meta":        { version, created, lastUpdated, questorId },
  "questCard":    { name, shape, xp, xpLog, cells, archive },
  "wheelOfLife":  { current, history },
  "freshCheckin": { entries },
  "madlib":       { ml1, mlVerb, ml3 … ml12c }
}
```

---

## `_meta`

| Field | Type | Description |
|-------|------|-------------|
| `version` | string | Schema version (semver) |
| `created` | ISO date string | When this file was first initialized |
| `lastUpdated` | ISO date string | When this file was last written |
| `questorId` | string | Optional unique identifier for the Questor |

---

## `questCard`

Data for the Quest Card tool (Tools page, first tab).

| Field | Type | Description |
|-------|------|-------------|
| `name` | string | Questor's name |
| `shape` | string | Chosen shape symbol: `✦` `◆` `★` `●` `▲` `⬡` |
| `xp` | number | Total XP earned |
| `xpLog` | array | Ordered log of XP events (newest first) |
| `cells` | array | All tasks on the board and in overflow |
| `archive` | array | Completed tasks that have been archived |

### `questCard.xpLog` entry

```json
{ "amount": 25, "label": "Quest Labs task ✓", "time": "10:42 AM" }
```

### `questCard.cells` entry

```json
{ "text": "Attend Week session", "xp": 25, "done": false, "col": 0 }
```

| Field | Type | Description |
|-------|------|-------------|
| `text` | string | Task label (user-editable) |
| `xp` | number | XP value for this task |
| `done` | boolean | Whether the task is marked complete |
| `col` | number | Column: `0`=Quest Labs `1`=School `2`=Work `3`=Home `4`=Joy of Being `−1`=Overflow/Sidequests |

### `questCard.archive` entry

```json
{ "text": "Deep work block (2hrs)", "xp": 20, "col": 2, "archivedAt": "Mar 17" }
```

---

## `wheelOfLife`

Data for the Wheel of Life tool (Tools page, second tab). 8 life areas scored 1–5.

**Area order (index 0–7):** Digital Diet · Organization · Friends · Family · School-work · Fun/Play · Health · Growth

| Field | Type | Description |
|-------|------|-------------|
| `current` | number[8] | Active slider values (1–5) for each area |
| `history` | array | Saved snapshots (newest first) |

### `wheelOfLife.history` entry

```json
{
  "date": "Mar 17, 2026",
  "values": [3, 4, 2, 3, 5, 3, 4, 3],
  "avg": "3.4"
}
```

`values` index maps to areas in the same order as `current`.

---

## `freshCheckin`

Data for the FRESH Check-in tool (Tools page, third tab). Each entry is one logged check-in.

**FRESH dimensions:** F=Focus · R=Relationships · E=Energy · S=Stimuli · H=Habits (each rated 1–10)

| Field | Type | Description |
|-------|------|-------------|
| `entries` | array | All logged check-ins (appended chronologically) |

### `freshCheckin.entries` entry

```json
{
  "id": 1,
  "time": "10:42 AM",
  "timestamp": "2026-03-17T10:42:00.000Z",
  "F": 7,
  "R": 6,
  "E": 8,
  "S": 5,
  "H": 6,
  "avg": 6,
  "tier": "good",
  "madlib": "Right now, my focus feels clear and well-directed..."
}
```

| Field | Type | Description |
|-------|------|-------------|
| `id` | number | Sequential entry number |
| `time` | string | Local time of the check-in |
| `timestamp` | ISO date string | Full UTC timestamp |
| `F` `R` `E` `S` `H` | number (1–10) | Score for each FRESH dimension |
| `avg` | number | Rounded average of F/R/E/S/H |
| `tier` | string | Self-selected tier: `"good"` `"better"` `"best"` |
| `madlib` | string | Generated reflection sentence at time of logging |

---

## `madlib`

The "Your 2032 Joy of Being" template (Madlib page). Each field maps to one blank.

| Field | Prompt fragment |
|-------|----------------|
| `ml1` | "In 2032, I am a ___" |
| `mlVerb` | "who ___" |
| `ml3` | "with and for ___" |
| `ml4` | "inside a world that has learned to ___" |
| `ml5` | "I am known for my ___" |
| `ml6a` | "I work at the intersection of ___ and…" |
| `ml6b` | "…and ___" |
| `ml7` | "The problem I exist to dissolve is ___" |
| `ml8a` | "My collaborators are ___" |
| `ml8b` | "because ___" |
| `ml9` | "I measure my work by ___" |
| `ml10` | "The world I'm building makes ___ obsolete" |
| `ml11` | "I became this by ___" |
| `ml12a` | "What I couldn't have known in 2025 was ___" |
| `ml12b` | "The title on my door says: ___" |
| `ml12c` | "The door is always ___" |

---

## How persistence works

The app uses two API endpoints (in `src/pages/api/`):

- `GET /api/load` — reads `db.json` and returns it as JSON; called on page load
- `POST /api/save` — receives updated sections and merges them back into `db.json`; called automatically on every state change

The page loads state from `/api/load` on boot (falls back to blank defaults if the server is unreachable). Every interaction that changes state — completing a task, moving a cell, adjusting a slider, logging a FRESH check-in — fires a background POST to `/api/save`. `db.json` is updated in place with `_meta.lastUpdated` stamped each time.

The file lives at the **project root** (not inside `src/`) so Astro's file watcher doesn't trigger hot reloads when it's written to.

## Direct scripting (optional)

```js
import { readFileSync, writeFileSync } from 'fs';

const db = JSON.parse(readFileSync('db.json', 'utf8'));
db.questCard.name = 'Joey';
db._meta.lastUpdated = new Date().toISOString();
writeFileSync('db.json', JSON.stringify(db, null, 2));
```

---

## Archived pages

The following pages are not used in this version of the app and have been moved to `src/pages/_archive/`:

- `cv.astro` — Questor CV
- `curators-log.astro` — Curator's Log
- `artifact-vault.astro` — Artifact Vault
- `joy-bingo.astro` — Joy Bingo
