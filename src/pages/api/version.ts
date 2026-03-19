export const prerender = false;

import type { APIRoute } from 'astro';
import { readFileSync } from 'fs';
import { join } from 'path';

export const GET: APIRoute = () => {
  const pkg = JSON.parse(readFileSync(join(process.cwd(), 'package.json'), 'utf8'));
  return new Response(JSON.stringify({ version: pkg.version }), {
    headers: { 'Content-Type': 'application/json' },
  });
};
