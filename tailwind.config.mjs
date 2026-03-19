/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,ts,tsx}'],
  theme: {
    extend: {
      colors: {
        bg:         '#000000',
        deep:       '#1A0B2B',
        ember:      '#453160',
        gold:       '#8B74AB',
        'gold-pale':'#b0a3c8',
        teal:       '#8E8E9A',
        'teal-dark':'#6a6a76',
        text:       '#f0ecf8',
        'text-dim': 'rgba(240,236,248,0.6)',
        'text-faint':'#8E8E9A',
      },
      fontFamily: {
        playfair: ['"Playfair Display"', 'serif'],
        mono: ['"Space Mono"', 'monospace'],
        sans: ['Mulish', 'sans-serif'],
      },
    },
  },
  plugins: [],
};
