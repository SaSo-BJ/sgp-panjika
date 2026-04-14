# Śrī Gadādhara Parivāra Panjikā — MVP 1
## Architecture & Planning Context Document (Updated)

---

## 1. Project Overview

A website that allows users to generate and download personalised Vaishnava calendar
(Panjikā) data for a chosen date range and location.

**User Inputs:**
- Start date (date picker)
- End date (date picker)
- Location (typeahead autocomplete from pre-defined list)
- Panjikā Style (dropdown — 4 options)

**Downloadable Outputs:**
- Panjikā data — tithis, nakshatras, ekādaśīs, festivals, sunrise/sunset, etc.
- Vratā Sūcī — list of vows, observances, and fasting days

**File formats:** .csv (primary), .xlsx (secondary, future)

**Tradition context:** Gaudiya Vaishnava — Śrī Gadādhara Parivāra.
- The tradition follows the **Purnimanta** calendar system
- However, the R scripts generate **Amanta** month names as output
  (this is a known characteristic of the current implementation)

---

## 2. Project Constraints

- Non-commercial, not-for-profit project
- Expected traffic: ~24 visitors/week initially; max ~50,000/year (considered highly
  inflated). Low-traffic by design.
- No paid hosting. No credit card where avoidable.
- Codebase will be public on GitHub — others may reference and build upon it later.
- This iteration uses R exclusively for backend computation.
- Future iterations (separate projects) may use different tools/stacks.
- Docker deferred to MVP 2.

---

## 3. Tech Stack Decisions

| Layer | Choice | Reason |
|---|---|---|
| Computation engine | R + VedicDateTime package | Already implemented; astronomy-accurate |
| Backend API framework | Plumber (R) | Native R REST wrapper; simplest integration |
| Frontend structure | Single-page HTML with anchor-linked sections | Eliminates bookmark/cold-start problem; simpler to build |
| Frontend styling | Bootstrap 5 (via CDN) + custom CSS | Layout handled by Bootstrap; visual richness via custom CSS |
| Frontend fonts | Google Fonts (via CDN) | Sanskrit-influenced typography; no installation needed |
| Frontend behaviour | Vanilla JavaScript | No framework needed; minimal logic |
| Frontend hosting | Render Static Site (primary) OR GitHub Pages / Netlify (alternatives) | Same platform as backend; free; no card for static sites |
| Backend hosting | Render Web Service (free tier) | Free; sufficient for traffic; try first before Koyeb |
| Backend fallback | Koyeb (no card, no sleep mode) | Requires Docker — deferred to MVP 2 |
| Output format | CSV (primary), XLSX (secondary) | write.csv() native in R; openxlsx for XLSX |
| Location data | Pre-defined JS array (local autocomplete) | No external API; timezone accuracy guaranteed |
| Date input | Native HTML `input[type="date"]` | Zero dependencies; works across all browsers |

---

## 4. R Scripts — Key Details

**Four separate R scripts, one per Panjikā style:**

| Style value (passed to backend) | Description |
|---|---|
| `vanilla_24hr` | Vanilla Panjikā — 24 hr format |
| `kshaya_24hr` | 24 hr format — including Kshaya Tithis |
| `arunodaya_24hr` | 24 hr format — including Arunodaya Time |
| `12hr` | 12 hr format |

Note: Column structure varies across the four scripts. Each style has its own
`colnames()` assignment in the Plumber wrapper.

**Core function signature (shared pattern across all four scripts):**
`get_panjika(start_date_jd, end_date_jd, place)`

**Inputs to the function:**
- `place` — numeric vector: `c(latitude, longitude, UTC_offset)`
  e.g. Vrindavan → `c(27.5650, 77.6593, +5.5)`
- `start_date_jd` — Julian date, converted from Gregorian via
  `gregorian_to_jd(DD, MM, YYYY)`
- `end_date_jd` — same as above

**Common output columns (present in all styles):**

| Column | Description |
|---|---|
| Dinanka | Date (DD-MM-YYYY) |
| Vara | Day of week |
| Suryodaya | Sunrise |
| Suryasta | Sunset |
| Tithi | Lunar day name |
| Tithi_Change | Time of tithi transition |
| Nakshatra | Lunar mansion name |
| Nakshatra_Change | Time of nakshatra transition |
| Paksha | Shukla Paksha / Krishna Paksha |
| Amanta_Masa | Month name (Amanta system) |

**Additional columns depending on style:**
- `arunodaya_24hr` includes: Arunodaya (96 minutes before sunrise)
- `kshaya_24hr` includes: Kshaya Tithi data
- `12hr` uses 12-hour time format throughout

**Static lookup vectors (loaded once at server startup):**
- `Tithis` — 30-element vector of tithi names
- `Pakshas` — 30-element vector mapping tithi_id to paksha
- `Nakshatras` — 27-element vector of nakshatra names

**VedicDateTime functions used internally:**
`sunrise()`, `sunset()`, `tithi()`, `nakshatra()`, `get_masa_name()`,
`get_vaara_name()`, `jd_to_gregorian()`, `gregorian_to_jd()`

**Vratā Sūcī script:** Ready for MVP 1. Will be exposed via a separate endpoint.

---

## 5. Backend Architecture

**Framework:** Plumber (R)

**Endpoints:**
- `GET  /ping` — wake-up endpoint; fired silently on every page load
- `POST /generate-panjika` — main Panjikā generation endpoint
- `POST /generate-vrata-suci` — Vratā Sūcī generation endpoint

**Parameters received by `/generate-panjika` (all arrive as strings):**
```
lat, lon, tz                    → as.numeric()
start_dd, start_mm, start_yyyy  → as.integer()
end_dd, end_mm, end_yyyy        → as.integer()
style                           → character, one of:
                                  "vanilla_24hr" | "kshaya_24hr" |
                                  "arunodaya_24hr" | "12hr"
```

**Routing logic (illustrative):**
```r
#* @post /generate-panjika
function(lat, lon, tz, start_dd, start_mm, start_yyyy,
         end_dd, end_mm, end_yyyy, style, res) {

  place      <- c(as.numeric(lat), as.numeric(lon), as.numeric(tz))
  start_date <- gregorian_to_jd(as.integer(start_dd), as.integer(start_mm),
                                as.integer(start_yyyy))
  end_date   <- gregorian_to_jd(as.integer(end_dd), as.integer(end_mm),
                                as.integer(end_yyyy))

  if (style == "vanilla_24hr") {
    panjika <- get_panjika_vanilla(start_date, end_date, place)
    colnames(panjika) <- c(...)   # columns for this style

  } else if (style == "kshaya_24hr") {
    panjika <- get_panjika_kshaya(start_date, end_date, place)
    colnames(panjika) <- c(...)

  } else if (style == "arunodaya_24hr") {
    panjika <- get_panjika_arunodaya(start_date, end_date, place)
    colnames(panjika) <- c(...)

  } else if (style == "12hr") {
    panjika <- get_panjika_12hr(start_date, end_date, place)
    colnames(panjika) <- c(...)

  } else {
    res$status <- 400
    return(list(error = "Invalid style parameter"))
  }

  buf <- textConnection("output_text", open = "w")
  write.csv(panjika, buf, row.names = FALSE)
  close(buf)
  csv_text <- paste(output_text, collapse = "\n")

  res$setHeader("Content-Type", "text/csv")
  res$setHeader("Content-Disposition",
                paste0("attachment; filename=panjika_", style, ".csv"))
  return(csv_text)
}
```

**Output mechanism:** In-memory CSV via `textConnection()` — no file written
to disk. Streamed directly as HTTP response. Filename reflects selected style.

---

## 6. Memory & Storage Model

**Persists in memory (loaded at startup, shared across all requests):**
- Tithis, Pakshas, Nakshatras vectors
- All four get_panjika function definitions
- Vratā Sūcī function definitions

**Lives only for the duration of one request-response cycle:**
- All local variables (place, dates, panjika dataframe, buffer, csv text)
- Automatically freed by R's garbage collector after response is sent
- No disk I/O, no cleanup needed

---

## 7. Frontend Architecture

**Structure:** Single HTML page (`index.html`) with anchor-linked sections,
plus a second page (`about.html`) for informational content.

**Page 1 — index.html (Landing page)**
```
#welcome          — Introduction, tradition context, calls to action
#panjika          — Panjikā Generator form + download
#vrata-suci       — Vratā Sūcī Generator form + download
```

**Page 2 — about.html**
```
About
Tools Used
Disclaimers
(further sections as needed)
```

**Navigation bar** links between the two pages and to sections within index.html.

**Form inputs (Panjikā Generator):**
- Start Date — `input[type="date"]` with native calendar picker
- End Date — `input[type="date"]` with native calendar picker
- Location — text input with JS typeahead filtering `locations.js` array
- Panjikā Style — `<select>` dropdown with 4 options

**Cursor behaviour on date picker:**
```css
input[type="date"] { cursor: default; }
input[type="date"]::-webkit-calendar-picker-indicator { cursor: pointer; }
```

**Wake-up ping (fired on every page load, both pages):**
```javascript
fetch("https://your-backend.onrender.com/ping")
```

**On form submit — JavaScript flow:**
1. Validate all fields filled
2. Validate start date < end date
3. Validate date range ≤ 366 days
4. Look up selected location → extract lat, lon, tz
5. Parse dates into DD, MM, YYYY
6. POST to `/generate-panjika` with all parameters
7. Receive CSV response → trigger browser file download

**Visual aesthetic:**
- Bootstrap 5 for layout and structure (via CDN)
- Custom CSS for tradition-appropriate styling:
  saffron/gold/green/ivory colour palette,
  Sanskrit-influenced Google Font for headings,
  ornamental dividers, generous whitespace

---

## 8. Location Data

**File:** `locations.js`
**Total entries:** 128 (91 India + 37 foreign including DST pairs)

**Format:**
```javascript
{ name: "Vrindavan, UP, India", lat: 27.5650, lon: 77.6593, tz: 5.5 }
```

**Indian coverage:** Braja Mandala pilgrimage sites, Navadvipa/Gaura Mandala
sites, other major pilgrimage sites, major cities across all regions.

**Foreign coverage:** UAE, Oman, Saudi Arabia, Kuwait, Qatar, Bahrain,
Mauritius, Kenya, South Africa, Singapore, Malaysia, Hong Kong, Australia,
New Zealand, UK, Netherlands, USA, Canada.

**DST handling:** Countries observing Daylight Saving Time have two entries
each — one for standard time, one for DST — with clear date range labels.
User selects the entry matching their date range period.

**All coordinates verified** from latlong.net and mapsofindia.com.
Four Braja Mandala sites (Govardhan, Barsana, Gokul, Nandagram) should be
cross-checked against Google Maps before public launch.

---

## 9. Security Assessment

**Not vulnerable to:**
- SQL Injection — no database
- Shell/Command Injection — no shell calls
- R Code Injection — all inputs coerced via as.numeric()/as.integer()
- File Path Traversal — no file paths accepted; in-memory output only
- Malicious file return — output assembled from server-defined vectors only

**Implemented before public hosting:**
- Input validation — numeric ranges for lat/lon/tz, start < end date
- Date range cap — maximum 366 days per request
- Style parameter validation — reject any value outside the four valid options
- CORS configuration — whitelist frontend domain in Plumber

**Deferred (evaluate after MVP 1):**
- Cloudflare rate limiting (IP-based, e.g. 20 requests/hour)
  — decision pending ease of implementation assessment

---

## 10. Expected Output File Size

- Approximately 60–120 KB per CSV for typical date ranges
- Well within all free tier limits across the entire stack
- No file size concerns at current scope

---

## 11. Open Items / Next Steps

- [ ] Finalise frontend visual design (colour palette, typography, layout)
- [ ] Write frontend HTML/CSS/JS code
- [ ] Define column structures for all four R scripts
  (needed to complete Plumber colnames() assignments)
- [ ] Share Vratā Sūcī R script for backend integration planning
- [ ] Decide final frontend hosting: Render Static Site vs GitHub Pages vs Netlify
- [ ] Set up GitHub repository (public)
- [ ] Deploy backend to Render — attempt Indian debit card for verification
  (fallback: Koyeb with Docker in MVP 2)
- [ ] Configure CORS in Plumber
- [ ] Add input validation and date range cap to Plumber wrapper
- [ ] Cross-check Govardhan, Barsana, Gokul, Nandagram coordinates
  against Google Maps before public launch
- [ ] Evaluate Cloudflare rate limiting post-MVP 1

---

## 12. About the Developer

Computer Science Engineering graduate. Strong theoretical foundations
(algorithms, networking, OS, databases, computer architecture). No hands-on
professional software engineering experience. Intermediate proficiency —
understands principles well, may need implementation-level guidance on
specific tools/syntax. Code is written by Claude; developer reviews and
directs.
