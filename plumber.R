# ── Load R source files ──────────────────────────────────────
source("panjika_consolidated_refactored_v2.R")
source("vrata_suci_fast_v3.R")

# ── Health check ─────────────────────────────────────────────
#* @get /health
function() {
  list(status = "ok")
}

# ── CORS filter ───────────────────────────────────────────────
#* @filter cors
function(req, res) {
  res$setHeader("Access-Control-Allow-Origin", "*")
  res$setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
  res$setHeader("Access-Control-Allow-Headers", "Content-Type")

  if (req$REQUEST_METHOD == "OPTIONS") {
    res$status <- 200
    return(list())
  }

  plumber::forward()
}