#!/bin/zsh
# Regenerate a QR code for any URL (e.g. your deployed wrapper).
# Usage: ./make-qr.sh "https://you.github.io/carnivore-report/"
set -e
cd "$(dirname "$0")"
URL="${1:-https://carnivorespotter.org/urban-carnivore-spotter/reports/create}"
OUT="${2:-qr-wrapper}"
./.venv/bin/python - "$URL" "$OUT" <<'PY'
import sys, segno
url, out = sys.argv[1], sys.argv[2]
q = segno.make(url, error='h')
q.save(out + ".png", scale=12, border=4, dark="#2f3b2f", light="white")
q.save(out + ".svg", scale=12, border=4, dark="#2f3b2f", light="white")
print("wrote %s.png / .svg -> %s" % (out, url))
PY
