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

# ── Panjikā endpoint ─────────────────────────────────────────
#* @post /generate-panjika
function(lat, lon, tz,
         start_dd, start_mm, start_yyyy,
         end_dd, end_mm, end_yyyy,
         style, res) {

  place      <- c(as.numeric(lat), as.numeric(lon), as.numeric(tz))
  start_date <- gregorian_to_jd(as.integer(start_dd), as.integer(start_mm), as.integer(start_yyyy))
  end_date   <- gregorian_to_jd(as.integer(end_dd),   as.integer(end_mm),   as.integer(end_yyyy))

  if (style == "24hr") {
    panjika <- get_panjika_vanilla(start_date, end_date, place)
  } else if (style == "24hr_kshaya") {
    panjika <- get_panjika_kshaya(start_date, end_date, place)
  } else if (style == "24hr_arunodaya") {
    panjika <- get_panjika_arunodaya(start_date, end_date, place)
  } else if (style == "12hr") {
    panjika <- get_panjika_12hr(start_date, end_date, place)
  } else {
    res$status <- 400
    return(list(error = "Invalid style parameter"))
  }

  buf <- textConnection("output_text", open = "w")
  write.csv(panjika, buf, row.names = FALSE)
  close(buf)
  csv_text <- paste(output_text, collapse = "\n")

  res$setHeader("Content-Type", "text/csv")
  res$setHeader("Content-Disposition", paste0("attachment; filename=panjika_", style, ".csv"))
  return(csv_text)
}

# ── Vrata Sūcī endpoint ──────────────────────────────────────
#* @post /generate-vrata-suci
function(lat, lon, tz,
         start_dd, start_mm, start_yyyy,
         end_dd, end_mm, end_yyyy,
         res) {

  place      <- c(as.numeric(lat), as.numeric(lon), as.numeric(tz))
  start_date <- gregorian_to_jd(as.integer(start_dd), as.integer(start_mm), as.integer(start_yyyy))
  end_date   <- gregorian_to_jd(as.integer(end_dd),   as.integer(end_mm),   as.integer(end_yyyy))

  if ((end_date - start_date) > MAX_RANGE_DAYS) {
    res$status <- 400
    return(list(error = "Maximum supported range is 10 years"))
  }

  n_panjika  <- get_basic_panjika_fast(start_date, end_date, place)
  vrata_table <- find_vratas_fast(n_panjika)

  buf <- textConnection("output_text", open = "w")
  write.csv(vrata_table, buf, row.names = FALSE)
  close(buf)
  csv_text <- paste(output_text, collapse = "\n")

  res$setHeader("Content-Type", "text/csv")
  res$setHeader("Content-Disposition", "attachment; filename=vrata_suci.csv")
  return(csv_text)
}
