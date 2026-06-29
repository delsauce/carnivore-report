# Carnivore Spotter — Raw Data Access Notes

Notes on pulling raw sighting data from the **Urban Carnivore Spotter**
(<https://carnivorespotter.org/urban-carnivore-spotter>), a project of the
Seattle Urban Carnivore Project (Woodland Park Zoo + Seattle University).

_Last verified: 2026-06-28_

---

## TL;DR

The site is an open-source React + Firebase app. Its backend is a set of
**public Firebase Cloud Functions** — the map just renders a JSON endpoint you
can hit directly. No auth needed for the main one.

```bash
curl -s "https://us-central1-seattlecarnivores-edca2.cloudfunctions.net/getReports" -o carnivore_reports.json
```

That returns the **entire dataset — ~17,827 reports (~6.4 MB JSON)**.

- Source code: <https://github.com/spatialdev/urban-carnivore-spotter>
- Firebase project ID: `seattlecarnivores-edca2`
- Functions base URL: `https://us-central1-seattlecarnivores-edca2.cloudfunctions.net/`

---

## Endpoints (same base URL)

| Endpoint | Status | Returns |
|---|---|---|
| `getReports` | ✅ 200 | **All** reports (Seattle + Tacoma merged), filtered field set |
| `getNeighborhoods` | ✅ 200 | List of all neighborhood names |
| `getReport?id=<id>` | ✅ | Single Seattle report — **richer fields** (adult/young counts, description, etc.) |
| `getTacomaReport?id=<id>` | ✅ | Single Tacoma report |
| `dataDump` | ⛔ 403 | Richer "everything" export, but auth-protected — use `getReports` instead |
| `addReport` (POST) | — | Submission endpoint (write) |

`getReports` supports query filters: `species`, `neighborhood`, `season`,
`year`, `time_of_day`, plus a lat/lng radius (default ~500 mi).

---

## Record shape (`getReports`)

```json
{
  "id": "Qbg4cXN3ZfwbMU1ewFKy",
  "data": {
    "timestamp": "2020-07-08T06:30:00.000Z",
    "species": "Opossum",
    "neighborhood": "Eastside-ENACT",
    "confidence": "100% confident",
    "time_submitted": { "_seconds": 1594267337, "_nanoseconds": 931000000 },
    "mediaPaths": [],
    "mapLng": -122.40018056403379,
    "mapLat": 47.1957624103923
  }
}
```

---

## Species breakdown (live data, 2026-06-28)

| Count | Species |
|------:|---------|
| 10,695 | Coyote |
| 2,588 | Raccoon |
| 1,726 | Bobcat |
| 1,185 | Black Bear |
| 810 | River Otter |
| 310 | Cougar/Mountain Lion |
| 306 | Opossum |
| 106 | Red Fox |
| 88 | Other/Unknown |
| 12 | Black Bear TEST |
| 1 | Unknown |

---

## Caveats

- `getReports` deliberately **omits free-text descriptions and submitter info**;
  coordinates are jittered/neighborhood-level for privacy. For fuller per-record
  fields, loop the IDs through `getReport?id=`.
- This is an **undocumented internal API**, not an official data product — it can
  change or be locked down without notice.
- For **research / citable use**: the project also publishes to
  [eMammal](https://emammal.si.edu/projects/seattle-urban-carnivore-project). The
  most legitimate path for a formal dataset is to email the
  [Seattle Urban Carnivore Project](https://zoo.org/seattlecarnivores/) and ask
  for a data-sharing agreement.

---

## Handy snippets

Download + count:
```bash
curl -s "https://us-central1-seattlecarnivores-edca2.cloudfunctions.net/getReports" -o carnivore_reports.json
python3 -c "import json;print(len(json.load(open('carnivore_reports.json'))))"
```

Convert to CSV:
```bash
python3 - <<'PY'
import json, csv
d = json.load(open("carnivore_reports.json"))
cols = ["id","timestamp","species","neighborhood","confidence","mapLat","mapLng"]
with open("carnivore_reports.csv","w",newline="") as f:
    w = csv.writer(f); w.writerow(cols)
    for r in d:
        x = r["data"]
        w.writerow([r["id"], x.get("timestamp"), x.get("species"),
                    x.get("neighborhood"), x.get("confidence"),
                    x.get("mapLat"), x.get("mapLng")])
print("wrote carnivore_reports.csv")
PY
```
