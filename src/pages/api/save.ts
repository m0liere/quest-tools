export const prerender = false;

import type { APIRoute } from 'astro';
import { readFileSync, writeFileSync } from 'fs';
import { join } from 'path';

export const POST: APIRoute = async ({ request }) => {
  try {
    const incoming = await request.json();
    const dbPath = join(process.cwd(), 'db.json');
    const { existsSync } = await import('fs');
    const current = existsSync(dbPath) ? JSON.parse(readFileSync(dbPath, 'utf8')) : {};

    const updated = {
      ...current,
      ...incoming,
      _meta: {
        ...current._meta,
        lastUpdated: new Date().toISOString(),
      },
    };

    writeFileSync(dbPath, JSON.stringify(updated, null, 2));
    return new Response(JSON.stringify({ ok: true }), {
      headers: { 'Content-Type': 'application/json' },
    });
  } catch (err) {
    return new Response(JSON.stringify({ ok: false, error: String(err) }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    });
  }
};
