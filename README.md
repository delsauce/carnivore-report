# Carnivore Spotter — Home-Screen Wrapper

A tiny static page that fixes the "Add to Home Screen → 404" problem on the
official site, without needing any change from the project maintainers.

## Why this exists

The official site's web manifest has `start_url: "./index.html"`, which the
app's router treats as an unknown route — so the saved home-screen icon opens a
404. This wrapper ships its **own** manifest whose `start_url` points straight at
the working report form, so the installed icon launches correctly. When scanned
in a normal browser it just redirects to the form.

## Files

- `index.html` — redirects to the report form; hosts the corrected manifest + iOS meta tags
- `manifest.json` — correct `start_url` → the live report form
- `icon-192.png`, `icon-512.png` — paw-print app icon

## Deploy (pick one — both free)

**GitHub Pages**
1. Create a repo, e.g. `carnivore-report`, and add these 4 files at the root.
2. Settings → Pages → deploy from `main` / root.
3. Your URL: `https://<you>.github.io/carnivore-report/`

**Netlify (drag-and-drop)**
1. Go to app.netlify.com → "Add new site" → "Deploy manually".
2. Drag this `wrapper/` folder onto the page.
3. Use the `*.netlify.app` URL it gives you.

## After deploying

1. Point your QR code at the deployed URL (regenerate with `../make-qr.sh <url>`).
2. On an iPhone: open the URL in Safari, Share → **Add to Home Screen**.
   It should now launch straight into the form, with the paw icon.

> Note: `display: standalone` + a real redirect is what makes the installed icon
> behave like an app. iOS reads *this* manifest's `start_url`, sidestepping the
> official site's broken one.
