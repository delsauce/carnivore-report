# Does Awareness Drive the Data? A Neighborhood Test of Citizen-Science Wildlife Reporting

**Summer 2026 urban-ecology & public-health research project**
A rising-senior field experiment in citizen-science surveillance, using coyote sightings in one Seattle neighborhood.

*Reworked June 2026. Technical setup is pre-resolved — see the Appendix to start building.*

---

## The one-sentence version (for the Common App activity / interviews)

> I designed and ran an 8-week neighborhood campaign to test whether a QR-code flyer increases public reporting of coyote sightings to a regional wildlife-tracking project — measuring scans and reports as a funnel, comparing against a control neighborhood, and sharing the results (plus a bug fix) back with the scientists who run the platform.

---

## The reframed question

Citizen-science surveillance systems — wildlife trackers, disease dashboards, pollution maps — only capture what the public *knows to report*. So a rise in "coyote sightings" can mean more coyotes **or** just more people aware of the reporting tool. That ambiguity (**reporting / ascertainment bias**) is a core problem in public-health surveillance.

**This project tests it directly:**

> Does a low-cost awareness intervention (a QR-code flyer pointing to an existing reporting tool) measurably increase the number of carnivore sightings reported from a target neighborhood?

This is a *public-health methods* question wearing an urban-ecology costume. The skills — surveillance design, controlling for confounders, honest measurement, science communication — transfer straight to epidemiology.

### Why it matters now
Seattle has a permanent, well-adapted urban coyote population, and reports cluster seasonally (pup-rearing, ~Feb–July). Agencies rely on voluntary citizen reports to know where human–wildlife conflict is happening. If a teenager with a stack of flyers can measurably move the reporting rate, that says something useful about how *any* voluntary surveillance system can be strengthened — cheaply.

---

## The experiment

### The intervention
A single QR-code flyer (plus the same link shared digitally) driving people to the official **Carnivore Spotter** report form. Posted across one **target neighborhood** for ~8 weeks. Every placement uses the **same** QR / link, so we get one clean total scan count.

### The funnel we measure
```
flyers/posts  →  QR scans  →  submitted reports
(what we do)     (we count    (official dataset,
                 directly)     estimated via diff-in-diff)
```

- **Scans** — counted directly via the redirect wrapper + GoatCounter. Fully attributable to us. Our cleanest, largest signal.
- **Reports** — pulled from the public Carnivore Spotter dataset for the target neighborhood. Confounded, so estimated with a control (below).
- **Conversion** — scans → reports. A finding in itself.

### Controlling for confounders (why a control neighborhood matters)
A naive before/after would be fooled by two things:
1. **Seasonality** — summer reports rise anyway → baseline against the *same calendar weeks in prior years* (2024, 2025), not against spring.
2. **Rising tool awareness over time** → a **control neighborhood** with no flyers, measured over the same weeks, soaks up the background trend.

**Difference-in-differences:**
> flyer effect ≈ (target during − target baseline) − (control during − control baseline)

Pick target and control to be similar: comparable size, green space, and historical report volume, so the comparison is fair.

---

## Data & tools (all pre-resolved — see Appendix)

| What | Where / how |
|---|---|
| **Existing sightings (baseline + outcome)** | Public Carnivore Spotter API — `getReports` returns all ~17.8k reports. **Appendix A4.** |
| **The report form (where the flyer sends people)** | `https://carnivorespotter.org/urban-carnivore-spotter/reports/create` |
| **Redirect wrapper (scan counting + app icon)** | The `wrapper/` folder — host free on GitHub Pages. **Appendix A2.** |
| **Scan counts** | GoatCounter (free, cookieless), one script tag on the wrapper. **Appendix A2.** |
| **QR code** | Pre-generated; regenerate for your wrapper URL with `make-qr.sh`. **Appendix A3.** |
| **Analysis** | A spreadsheet is enough; a short Python snippet for the data pull is in **Appendix A4.** |

### Background reading (verify any stat before quoting it)
- **Seattle Urban Carnivore Project** (Woodland Park Zoo + Seattle University) — progress reports, camera-trap research.
- **Carnivore Spotter** map — the live citizen-science tool.
- **WDFW** urban coyote guidance — coexistence, hazing, when to report aggressive animals.
- **Schell Lab** (Dr. Christopher Schell, UC Berkeley) — urban coyote ecology; good for the "why coexistence/habituation matters" framing.
- *Note:* the earlier draft cited specific figures (e.g., "23.06% of detections," "73+ coyotes"). Trace each to a named source before using it; cut anything you can't point to.

---

## Methods detail

**Defining the study areas.** Filter the dataset by the neighborhood label, or — better — draw a map polygon from lat/long so it matches exactly where flyers go. Do the same for the control area.

**Computing the baseline.** For each area, count reports per week over the matching weeks in 2024 and 2025 (and the trailing 12 months). That's your "expected" rate. (No waiting required — the dataset is historical.)

**Running the campaign.** Post the flyer/link across the target neighborhood on day 1 of the window; note dates and locations. Refresh any that come down. Record the GoatCounter scan total weekly so you can see the time course.

**Pulling the outcome.** Re-pull the dataset at the mid-point and end. Count reports in each area during the window. Apply the difference-in-differences formula.

### Ethics & safety (short but real)
- **It's about reporting, not approaching.** The campaign drives people to log sightings from a safe distance — never to seek out or interact with coyotes. Put a one-line safety note on the flyer (keep dogs leashed, don't feed/approach).
- **Post where it's allowed** — community bulletin boards, libraries, coffee shops *with permission*, dog parks per their rules, HOA/newsletter, and digital (Nextdoor / neighborhood groups). Don't staple to utility poles where prohibited.
- **No personal data collected.** GoatCounter is cookieless; the wrapper only counts anonymous scans and hands off to the official form — it never sees what anyone submits.
- **You're amplifying an official tool**, not creating a competing one — a point worth making to the project's scientists.

---

## ~8-week timeline (target start: week of July 7, 2026)

**Week 0 — Setup (use the Appendix; most of this is pre-built)**
- Lock the question and hypothesis; write the one-paragraph problem statement.
- Choose target + control neighborhoods (similar profile); justify the pairing.
- Pull the dataset; compute baseline weekly report rates for both areas (2024, 2025, trailing 12 mo). *(Appendix A4.)*
- Deploy the wrapper to GitHub Pages; add your GoatCounter code; test the QR on a phone. *(Appendix A2–A3.)*
- Design + print the flyer (QR, one-line safety note, "logs to Woodland Park Zoo's project").

**Weeks 1–8 — Campaign live**
- Post across the target neighborhood; log every placement (where, when).
- Record the scan total weekly; watch the time course.
- **Mid-point (≈ Week 4):** pull interim report data, sanity-check the funnel, top up flyers.

**Weeks 7–8 — Analyze & write**
- Re-pull the dataset; compute campaign-window report rates.
- Run the difference-in-differences; build the funnel (scans → reports).
- Draft findings using the spine: **how surveillance bias works → what the funnel shows → what it means for voluntary reporting systems.**
- State limitations honestly (small n, scan ≠ unique person, single neighborhood, parallel-trends assumption).

**Wrap-up — Communicate & report back**
- **Neighborhood one-pager:** "Here's what we saw, here's how to keep reporting, thanks for participating."
- **Short findings brief + 5-slide deck** with the funnel chart and the target-vs-control comparison.
- **Report back to the source:** email findings to Woodland Park Zoo / Seattle Urban Carnivore Project — *and include the manifest bug fix* (Appendix A6) so their "Add to Home Screen" works. (A contribution, not just a request.)

---

## Deliverables
1. **Findings brief** (~2 pages) — question, method, funnel results, limitations.
2. **5-slide deck** — for a science teacher, a neighborhood group, or the project scientists.
3. **Neighborhood one-pager** — plain-language thank-you + how to keep reporting.
4. **Report-back email** to Woodland Park Zoo / SUCP — results + the app fix.
5. **Clean dataset + spreadsheet** — baseline, weekly counts, scan log (reproducible).

## Future work / stretch goals (name these in the report)
- **Per-channel attribution.** Use a separate link per placement (dog park vs. library vs. Nextdoor) to learn *which* channel drives scans — not just whether the campaign worked overall. (Deliberately left out of this pilot to keep it simple; an obvious next step.)
- **Flyer A/B test** — alarming vs. friendly wording on separate links.
- **Extend to all carnivore species** (not just coyote) for bigger numbers.

## Honest limitations (say these out loud — they signal maturity)
- Single neighborhood, short window → a **pilot**, not a definitive study. Report raw counts and effect sizes, not p-values you can't support.
- A scan isn't a unique person; a report isn't a unique reporter.
- Difference-in-differences assumes target and control would have trended together absent the flyers — name it, defend the pairing, acknowledge the risk.
- A single total scan count tells you *how many* engaged, not *where they saw the flyer* — hence per-channel attribution as future work.

---

## How to talk about it (activity blurb, ~150 chars)
> Designed/ran an 8-wk citizen-science campaign testing whether a QR flyer boosts neighborhood wildlife reporting; measured impact vs. a control area; shared results + an app fix with the regional project.

---
---

# Appendix — Resolved technical setup (start here to build)

Everything below is already worked out and sitting in this folder. The student can build the whole measurement rig in an afternoon.

## A0. Quick-start checklist (Week 0, in order)
1. **Pick neighborhoods** — one target, one similar control (A4 lists the valid names).
2. **Deploy the wrapper** to GitHub Pages (A2).
3. **Add your GoatCounter code** to the wrapper and confirm a test scan registers (A2).
4. **Regenerate the QR** for your GitHub Pages URL (A3).
5. **Pull the baseline** report counts for both neighborhoods (A4).
6. **Print the flyer** with the QR + safety line.
7. Go live.

## A1. Files in this folder
| File | Purpose |
|---|---|
| `coyote-reporting-project-plan.md` | This plan. |
| `carnivore-spotter-data-access.md` | Full notes on the data API. |
| `wrapper/` | The redirect page (scan counter + app icon) to deploy. |
| `wrapper/index.html` | Redirects to the form; hosts GoatCounter + iOS install tags. |
| `wrapper/manifest.json` | Fixes the "Add to Home Screen" 404; sets the app icon. |
| `wrapper/icon-192.png`, `icon-512.png` | Paw-print app icon. |
| `qr-form-direct.png` / `.svg` | QR straight to the form (works today; for testing). |
| `make-qr.sh` | Regenerate a QR for any URL. |
| `manifest-fix.diff` | One-line fix to send the project maintainers. |
| `.venv/` | Python env with `segno` (QR) + `pillow` (icon). |

## A2. The wrapper + scan counting (GoatCounter)
**What it does:** when someone scans the QR, the wrapper page loads, GoatCounter records the scan, then it redirects (~0.9s) to the official report form. It also carries the corrected web-app manifest so "Add to Home Screen" works.

**Set up the counter (one-time, ~10 min):**
1. Create a free account at **https://www.goatcounter.com/** → you get a site code (e.g. `coyote2026`).
2. In `wrapper/index.html`, find `YOURCODE` and replace it with your code.
3. (GoatCounter is cookieless and stores no personal data — no cookie banner needed.)

**Deploy the wrapper (free, pick one):**
- **GitHub Pages:** put the 4 wrapper files in a repo root → Settings ▸ Pages ▸ deploy from `main`/root → URL like `https://<you>.github.io/<repo>/`.
- **Netlify:** app.netlify.com ▸ "Add new site" ▸ "Deploy manually" ▸ drag the `wrapper/` folder.

**Read the data:** the GoatCounter dashboard shows total scans and a time-series graph. Export CSV for the write-up.

**Sanity check:** scan the QR yourself; confirm the count ticks up and you land on the form.

> Note: the redirect is intentionally delayed ~0.9s so the scan registers before the page navigates away. Don't set it to 0.

## A3. Generating / regenerating the QR
The QR must point at **your deployed wrapper URL**.
```bash
cd ~/Documents/coyote
./make-qr.sh "https://<you>.github.io/<repo>/"
```
Outputs `qr-wrapper.png` (print/social) and `qr-wrapper.svg` (scales to poster size). High error-correction, so it survives printing and weather.

## A4. Pulling the existing data (the baseline + outcome)
**Download everything (~17,827 reports, no auth):**
```bash
curl -s "https://us-central1-seattlecarnivores-edca2.cloudfunctions.net/getReports" -o reports.json
```
**Valid neighborhood names:**
```bash
curl -s "https://us-central1-seattlecarnivores-edca2.cloudfunctions.net/getNeighborhoods"
```
**Record shape:** `{ id, data: { timestamp, species, neighborhood, confidence, time_submitted, mediaPaths, mapLng, mapLat } }`

**Weekly counts for one neighborhood + species (baseline starter):**
```python
import json, collections, datetime
d = json.load(open("reports.json"))
NB, SP = "Wedgwood", "Coyote"          # <-- set your target neighborhood / species
weeks = collections.Counter()
for r in d:
    x = r["data"]
    if x.get("neighborhood") == NB and x.get("species") == SP and isinstance(x.get("timestamp"), str):
        dt = datetime.datetime.fromisoformat(x["timestamp"].replace("Z", "+00:00"))
        weeks[dt.strftime("%Y-W%V")] += 1   # ISO year-week
for wk in sorted(weeks):
    print(wk, weeks[wk])
```
Run the same for your control neighborhood. Compare the summer-2026 weeks to the same weeks in 2024/2025. (Use lat/long instead of the label if you want a precise polygon.)

> `dataDump` exists but returns 403 (auth-protected). Use `getReports` — it has everything you need.

## A5. Dataset facts (as of June 2026 — re-verify at write-up time)
- **Size:** ~17,827 reports, back to 2020. Covers Seattle + Tacoma collections (merged).
- **Most-reported species:** Coyote (~10,700), Raccoon (~2,600), Bobcat (~1,700), Black Bear (~1,200), River Otter (~810), Cougar (~310).
- **Still active:** latest sighting was ~10 days before this was written — people are reporting now.
- **Website last code update:** ~Dec 30, 2025 (the front-end deploy). The public GitHub repo is archived, so email is the way to reach the maintainers.

## A6. The fix to send the maintainers (`manifest-fix.diff`)
The official site's "Add to Home Screen" opens a 404 because its manifest sets `start_url: "./index.html"`, which the app's router treats as an unknown route. One-line fix in their `public/manifest.json`:
```diff
-  "start_url": "./index.html",
+  "start_url": ".",
```
Include this in the report-back email. (Full diff + explanation in `manifest-fix.diff`.) The student's wrapper already works around this on their end; the diff fixes it for everyone.
