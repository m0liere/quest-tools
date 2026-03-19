export const prerender = false;

import type { APIRoute } from 'astro';
import { writeFileSync, mkdirSync } from 'fs';
import { join, extname } from 'path';

export const POST: APIRoute = async ({ request }) => {
  try {
    const formData = await request.formData();
    const file = formData.get('portrait') as File;
    if (!file) {
      return new Response(JSON.stringify({ ok: false, error: 'No file' }), { status: 400 });
    }

    const ext = extname(file.name) || '.jpg';
    const filename = `portrait${ext}`;
    const dir = join(process.cwd(), 'public', 'portraits');
    mkdirSync(dir, { recursive: true });

    const buffer = Buffer.from(await file.arrayBuffer());
    writeFileSync(join(dir, filename), buffer);

    return new Response(JSON.stringify({ ok: true, filename }), {
      headers: { 'Content-Type': 'application/json' },
    });
  } catch (err) {
    return new Response(JSON.stringify({ ok: false, error: String(err) }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    });
  }
};
