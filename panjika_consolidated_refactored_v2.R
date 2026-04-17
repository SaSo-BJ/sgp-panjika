# invoking the "already installed" VedicDateTime package
library(VedicDateTime)
library(memoise)

# ===============================================================
# Global Variables
# ===============================================================

Tithis <- c(
  "Pratipada", "Dwitiya", "Tritiya", "Chaturthi", "Panchami",
  "Shashthi", "Saptami", "Ashtami", "Navami", "Dashami",
  "Ekadashi", "Dwadashi", "Trayodashi", "Chaturdashi", "Purnima",
  "Pratipada", "Dwitiya", "Tritiya", "Chaturthi", "Panchami",
  "Shashthi", "Saptami", "Ashtami", "Navami", "Dashami",
  "Ekadashi", "Dwadashi", "Trayodashi", "Chaturdashi", "Amavasya"
)

Pakshas <- c(
  rep("Shukla Paksha", 15),
  rep("Krishna Paksha", 15)
)

Nakshatras <- c(
  "Ashwini", "Bharani", "Kritika", "Rohini", "Mrigashira",
  "Ardra", "Punarvasu", "Pushya", "Ashlesha", "Magha",
  "Purvaphalguni", "Uttaraphalguni", "Hasta", "Chitra", "Swati",
  "Vishakha", "Anuradha", "Jyeshtha", "Mula", "Purvashada",
  "Uttarashada", "Shravana", "Dhanishta", "Shatabhisha",
  "Purvabhadrapada", "Uttarabhadrapada", "Revati"
)

one_day_sec <- 24 * 60 * 60
two_muhurtas <- 2 * 48 * 60

str1 <- "-"
str2 <- ":"
str3 <- " "

# ===============================================================
# MEMOIZED WRAPPERS
# ===============================================================
# These cache astronomical computations across requests.
# Major speed gains occur when users request overlapping dates/locations.

memo_sunrise <- memoise(function(jd, place) sunrise(jd, place))
memo_sunset <- memoise(function(jd, place) sunset(jd, place))
memo_tithi <- memoise(function(jd, place) tithi(jd, place))
memo_nakshatra <- memoise(function(jd, place) nakshatra(jd, place))
memo_masa <- memoise(function(jd, place) get_masa_name(jd, place))
memo_vaara <- memoise(function(jd) get_vaara_name(jd))
memo_gregorian <- memoise(function(jd) jd_to_gregorian(jd))

# ===============================================================
# Utility Functions
# ===============================================================

to_sec <- function(x) {
  x[1] * 3600 + x[2] * 60 + x[3]
}

to_hms <- function(x) {
  s <- x %% 60
  rem_s <- x %/% 60
  m <- rem_s %% 60
  h <- rem_s %/% 60
  c(h, m, s)
}

norm_time <- function(x) {
  if (x >= 60*60 & x < 13*60*60) {
    return(x)
  } else if (x < 60*60) {
    return(x + 12*60*60)
  } else {
    x <- x - 12*60*60
    norm_time(x)
  }
}

build_df_fast <- function(rows_list, col_names) {
  df <- as.data.frame(do.call(rbind, rows_list), stringsAsFactors = FALSE)
  colnames(df) <- col_names
  return(df)
}

# ===============================================================
# PANJIKA GENERATORS
# ===============================================================

get_panjika_vanilla <- function(start_date_jd, end_date_jd, place) {

  n <- end_date_jd - start_date_jd + 1
  rows <- vector("list", n)
  idx <- 1

  for (jd in start_date_jd:end_date_jd) {

    sunrise_d <- memo_sunrise(jd, place)[2:4]
    sunset_d <- memo_sunset(jd, place)[2:4]
    tithi_d <- memo_tithi(jd, place)
    nakshatra_d <- memo_nakshatra(jd, place)
    amanta_masa <- memo_masa(jd, place)
    vara <- memo_vaara(jd)
    gc_date <- memo_gregorian(jd)

    rows[[idx]] <- c(
      paste(gc_date[3], str1, gc_date[2], str1, gc_date[1]),
      vara,
      paste(sunrise_d[1], str2, sunrise_d[2], str2, sunrise_d[3]),
      paste(sunset_d[1], str2, sunset_d[2], str2, sunset_d[3]),
      Tithis[tithi_d[1]],
      paste(tithi_d[2], str2, tithi_d[3], str2, tithi_d[4]),
      Nakshatras[nakshatra_d[1]],
      paste(nakshatra_d[2], str2, nakshatra_d[3], str2, nakshatra_d[4]),
      Pakshas[tithi_d[1]],
      amanta_masa
    )

    idx <- idx + 1
  }

  build_df_fast(rows,
    c("Date","Vara","Sunrise","Sunset","Tithi","Tithi_Change",
      "Nakshatra","Nakshatra_Change","Paksha","Amanta_Masa"))
}

# ===============================================================

get_panjika_kshaya <- function(start_date_jd, end_date_jd, place) {

  max_rows <- (end_date_jd - start_date_jd + 1) * 3
  rows <- vector("list", max_rows)
  idx <- 1

  for (jd in start_date_jd:end_date_jd) {

    sunrise_d <- memo_sunrise(jd, place)[2:4]
    sunset_d <- memo_sunset(jd, place)[2:4]
    tithi_d <- memo_tithi(jd, place)
    nakshatra_d <- memo_nakshatra(jd, place)
    amanta_masa <- memo_masa(jd, place)
    vara <- memo_vaara(jd)
    gc_date <- memo_gregorian(jd)

    rows[[idx]] <- c(
      paste(gc_date[3], str1, gc_date[2], str1, gc_date[1]),
      vara,
      paste(sunrise_d[1], str2, sunrise_d[2], str2, sunrise_d[3]),
      paste(sunset_d[1], str2, sunset_d[2], str2, sunset_d[3]),
      Tithis[tithi_d[1]],
      paste(tithi_d[2], str2, tithi_d[3], str2, tithi_d[4]),
      Nakshatras[nakshatra_d[1]],
      paste(nakshatra_d[2], str2, nakshatra_d[3], str2, nakshatra_d[4]),
      Pakshas[tithi_d[1]],
      amanta_masa
    )
    idx <- idx + 1

    if (length(tithi_d) == 8) {
      rows[[idx]] <- c(
        str3, str3, str3, str3,
        Tithis[tithi_d[5]],
        paste(tithi_d[6], str2, tithi_d[7], str2, tithi_d[8]),
        str3, str3, str3, str3
      )
      idx <- idx + 1
    }

    if (length(nakshatra_d) == 8) {
      rows[[idx]] <- c(
        str3, str3, str3, str3,
        str3, str3,
        Nakshatras[nakshatra_d[5]],
        paste(nakshatra_d[6], str2, nakshatra_d[7], str2, nakshatra_d[8]),
        str3, str3
      )
      idx <- idx + 1
    }
  }

  rows <- rows[1:(idx-1)]

  build_df_fast(rows,
    c("Date","Vara","Sunrise","Sunset","Tithi","Tithi_Change",
      "Nakshatra","Nakshatra_Change","Paksha","Amanta_Masa"))
}

# ===============================================================

get_panjika_arunodaya <- function(start_date_jd, end_date_jd, place) {

  n <- end_date_jd - start_date_jd + 1
  rows <- vector("list", n)
  idx <- 1

  for (jd in start_date_jd:end_date_jd) {

    sunrise_d <- memo_sunrise(jd, place)[2:4]
    arunodaya_sec <- to_sec(sunrise_d) - two_muhurtas
    arunodaya_d <- to_hms(arunodaya_sec)

    sunset_d <- memo_sunset(jd, place)[2:4]
    tithi_d <- memo_tithi(jd, place)
    nakshatra_d <- memo_nakshatra(jd, place)
    amanta_masa <- memo_masa(jd, place)
    vara <- memo_vaara(jd)
    gc_date <- memo_gregorian(jd)

    rows[[idx]] <- c(
      paste(gc_date[3], str1, gc_date[2], str1, gc_date[1]),
      vara,
      paste(sunrise_d[1], str2, sunrise_d[2], str2, sunrise_d[3]),
      paste(arunodaya_d[1], str2, arunodaya_d[2], str2, arunodaya_d[3]),
      paste(sunset_d[1], str2, sunset_d[2], str2, sunset_d[3]),
      Tithis[tithi_d[1]],
      paste(tithi_d[2], str2, tithi_d[3], str2, tithi_d[4]),
      Nakshatras[nakshatra_d[1]],
      paste(nakshatra_d[2], str2, nakshatra_d[3], str2, nakshatra_d[4]),
      Pakshas[tithi_d[1]],
      amanta_masa
    )

    idx <- idx + 1
  }

  build_df_fast(rows,
    c("Date","Vara","Sunrise","Arunodaya","Sunset","Tithi",
      "Tithi_Change","Nakshatra","Nakshatra_Change",
      "Paksha","Amanta_Masa"))
}

# ===============================================================

get_panjika_12hr <- function(start_date_jd, end_date_jd, place) {

  n <- end_date_jd - start_date_jd + 1
  rows <- vector("list", n)
  idx <- 1

  for (jd in start_date_jd:end_date_jd) {

    sunrise_d <- memo_sunrise(jd, place)[2:4]
    sunrise_d_sec <- to_sec(sunrise_d)

    arunodaya_sec <- sunrise_d_sec - two_muhurtas
    arunodaya_d <- to_hms(arunodaya_sec)

    sunset_d <- memo_sunset(jd, place)[2:4]
    sunset_d_sec <- to_sec(sunset_d)
    sunset_d2 <- to_hms(sunset_d_sec - 12*60*60)

    tithi_d <- memo_tithi(jd, place)
    tithi_d_sec <- to_sec(tithi_d[2:4])

    nakshatra_d <- memo_nakshatra(jd, place)
    nakshatra_d_sec <- to_sec(nakshatra_d[2:4])

    amanta_masa <- memo_masa(jd, place)
    vara <- memo_vaara(jd)
    gc_date <- memo_gregorian(jd)

    tithi_dira <- ifelse(
      tithi_d_sec >= sunrise_d_sec & tithi_d_sec <= sunset_d_sec,
      "Di", "Ra"
    )

    nakshatra_dira <- ifelse(
      nakshatra_d_sec >= sunrise_d_sec & nakshatra_d_sec <= sunset_d_sec,
      "Di", "Ra"
    )

    tithi_d2 <- to_hms(norm_time(tithi_d_sec))

    if (nakshatra_d_sec >= 13*60*60 & nakshatra_d_sec < 25*60*60) {
      nakshatra_d2 <- to_hms(nakshatra_d_sec - 12*60*60)
    } else if (nakshatra_d_sec < 60*60) {
      nakshatra_d2 <- to_hms(nakshatra_d_sec + 12*60*60)
    } else if (nakshatra_d_sec >= 25*60*60) {
      nakshatra_d2 <- to_hms(nakshatra_d_sec - 24*60*60)
    } else {
      nakshatra_d2 <- to_hms(nakshatra_d_sec)
    }

    rows[[idx]] <- c(
      amanta_masa,
      Pakshas[tithi_d[1]],
      paste(gc_date[3], str1, gc_date[2], str1, gc_date[1]),
      vara,
      Tithis[tithi_d[1]],
      tithi_dira,
      paste(tithi_d2[1], str2, tithi_d2[2]),
      Nakshatras[nakshatra_d[1]],
      nakshatra_dira,
      paste(nakshatra_d2[1], str2, nakshatra_d2[2]),
      paste(sunrise_d[1], str2, sunrise_d[2]),
      paste(sunset_d2[1], str2, sunset_d2[2]),
      paste(arunodaya_d[1], str2, arunodaya_d[2], str2, arunodaya_d[3])
    )

    idx <- idx + 1
  }

  build_df_fast(rows,
    c("Amanta_Masa","Paksha","Date","Vara","Tithi",
      "Tithi_DIRA","Tithi_Change","Nakshatra",
      "Nakshatra_DIRA","Nakshatra_Change",
      "Sunrise","Sunset","Arunodaya"))
}
