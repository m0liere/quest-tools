export const prerender = false;

import type { APIRoute } from 'astro';
import { readFileSync, existsSync } from 'fs';
import { join } from 'path';

const DEFAULT_DB = {
  _meta: { version: '1.0.0', created: '', lastUpdated: '', questorId: '' },
  questCard: { name: '', xp: 0, xpLog: [], cells: [], archive: [] },
  wheelOfLife: { current: [], history: [] },
  freshCheckin: { entries: [] },
  questorProfile: {
    portrait: '',
    iAm: '',
    about: { age: '', faveFood: '', faveMovie: '', faveSubject: '', dreamJob: '', whoIAdmire: '' },
    q1: '', q2: '', q3: '', q4: '', q5: '', q6: '', q7: '',
  },
  madlib: {
    ml1: '', mlVerb: '', ml3: '', ml4: '', ml5: '',
    ml6a: '', ml6b: '', ml7: '', ml8a: '', ml8b: '',
    ml9: '', ml10: '', ml11: '', ml12a: '', ml12b: '', ml12c: '',
  },
};

export const GET: APIRoute = () => {
  const dbPath = join(process.cwd(), 'db.json');
  const data = existsSync(dbPath) ? readFileSync(dbPath, 'utf8') : JSON.stringify(DEFAULT_DB);
  return new Response(data, {
    headers: { 'Content-Type': 'application/json' },
  });
};
