#* @get /health
function() {
  list(status = "ok")
}

# invoking the "already installed" VedicDateTime package
library(VedicDateTime)

# Initializing Global Variables

# tithi_id 1 is for the shukla paksha pratipada -> Following the Amanta calendar
Tithis <- c( "Pratipada", "Dwitiya", "Tritiya", "Chaturthi", "Panchami",
			"Shashthi", "Saptami", "Ashtami", "Navami", "Dashami",
			"Ekadashi", "Dwadashi", "Trayodashi", "Chaturdashi", "Purnima",
			"Pratipada", "Dwitiya", "Tritiya", "Chaturthi", "Panchami",
			"Shashthi", "Saptami", "Ashtami", "Navami", "Dashami",
			"Ekadashi", "Dwadashi", "Trayodashi", "Chaturdashi", "Amavasya")

Pakshas <- c("Shukla Paksha", "Shukla Paksha", "Shukla Paksha", "Shukla Paksha", "Shukla Paksha", 
			 "Shukla Paksha", "Shukla Paksha", "Shukla Paksha", "Shukla Paksha", "Shukla Paksha", 
			 "Shukla Paksha", "Shukla Paksha", "Shukla Paksha", "Shukla Paksha", "Shukla Paksha",
			 "Krishna Paksha", "Krishna Paksha", "Krishna Paksha", "Krishna Paksha", "Krishna Paksha", 
			 "Krishna Paksha", "Krishna Paksha", "Krishna Paksha", "Krishna Paksha", "Krishna Paksha", 
			 "Krishna Paksha", "Krishna Paksha", "Krishna Paksha", "Krishna Paksha", "Krishna Paksha")

Nakshatras <- c( "Ashwini", "Bharani", "Kritika", "Rohini", "Mrigashira",
				 "Ardra", "Punarvasu", "Pushya", "Ashlesha", "Magha",
				 "Purvaphalguni", "Uttaraphalguni", "Hasta", "Chitra", "Swati",
				 "Vishakha", "Anuradha", "Jyeshtha", "Mula", "Purvashada",
				 "Uttarashada", "Shravana", "Dhanishta", "Shatabhisha", "Purvabhadrapada",
				 "Uttarabhadrapada", "Revati")

one_day_sec <- 24*60*60
two_muhurtas <- 2*48*60

str1 <- "-"
str2 <- ":"
str3 <- " "

# Initializing Functions

to_sec <- function(x){
     y <- x[1]*60*60 + x[2]*60 + x[3]
     return(y)
}

to_hms <- function(x){
	s <- x %% 60
	rem_s <- x %/% 60
	m <- rem_s %% 60
	h <- rem_s %/% 60
	return(c(h,m,s))
}

norm_time <- function(x){

	if (x >= 60*60 & x < 13*60*60){
		return(x)
	} else if (x < 60*60){
		return(x + 12*60*60)
	} else {
		x <- x - 12*60*60
		norm_time(x)
	}
}

get_panjika_vanilla <- function (start_date_jd, end_date_jd, place){

	text_panjika = data.frame(matrix( 
  					vector(), 0, 10, dimnames=list(c(), c("Date", "Vara", "Sunrise", "Sunset", "Tithi", "Tithi_Change", 
  														 "Nakshatra", "Nakshatra_Change", "Paksha", "Amanta_Masa"))), 
                	stringsAsFactors=F)

	for (jd in start_date_jd:end_date_jd){

		sunrise_d <- sunrise(jd,place)[2:4]
		sunset_d <- sunset(jd,place)[2:4]
		tithi_d <- tithi(jd,place)
		nakshatra_d <- nakshatra(jd,place)
		amanta_masa <- get_masa_name(jd,place)
		vara <- get_vaara_name(jd)

		gc_date <- jd_to_gregorian(jd)
		date1 <- paste(gc_date[3], str1, gc_date[2], str1, gc_date[1])
		sunrise1 <- paste(sunrise_d[1], str2, sunrise_d[2], str2, sunrise_d[3])
		sunset1 <- paste(sunset_d[1], str2, sunset_d[2], str2, sunset_d[3])
		tithi1 <- Tithis[tithi_d[1]]
		tithi_change <- paste(tithi_d[2], str2, tithi_d[3], str2, tithi_d[4])
		nakshatra1 <- Nakshatras[nakshatra_d[1]]
		nakshatra_change <- paste(nakshatra_d[2], str2, nakshatra_d[3], str2, nakshatra_d[4])
		paksha <- Pakshas[tithi_d[1]]

		New_Entry2 <- c(date1, vara, sunrise1, sunset1, tithi1, tithi_change, nakshatra1, nakshatra_change, paksha, amanta_masa)
		text_panjika <- rbind(text_panjika, New_Entry2)
	}

	return(text_panjika)
}

get_panjika_kshaya <- function (start_date_jd, end_date_jd, place){

	text_panjika = data.frame(matrix( 
  					vector(), 0, 10, dimnames=list(c(), c("Date", "Vara", "Sunrise", "Sunset", "Tithi", "Tithi_Change", 
  														 "Nakshatra", "Nakshatra_Change", "Paksha", "Amanta_Masa"))), 
                	stringsAsFactors=F)

	for (jd in start_date_jd:end_date_jd){

		sunrise_d <- sunrise(jd,place)[2:4]
		sunset_d <- sunset(jd,place)[2:4]
		tithi_d <- tithi(jd,place)
		nakshatra_d <- nakshatra(jd,place)
		amanta_masa <- get_masa_name(jd,place)
		vara <- get_vaara_name(jd)

		gc_date <- jd_to_gregorian(jd)
		date1 <- paste(gc_date[3], str1, gc_date[2], str1, gc_date[1])
		sunrise1 <- paste(sunrise_d[1], str2, sunrise_d[2], str2, sunrise_d[3])
		sunset1 <- paste(sunset_d[1], str2, sunset_d[2], str2, sunset_d[3])
		tithi1 <- Tithis[tithi_d[1]]
		tithi_change <- paste(tithi_d[2], str2, tithi_d[3], str2, tithi_d[4])
		nakshatra1 <- Nakshatras[nakshatra_d[1]]
		nakshatra_change <- paste(nakshatra_d[2], str2, nakshatra_d[3], str2, nakshatra_d[4])
		paksha <- Pakshas[tithi_d[1]]

		New_Entry2 <- c(date1, vara, sunrise1, sunset1, tithi1, tithi_change, nakshatra1, nakshatra_change, paksha, amanta_masa)
		text_panjika <- rbind(text_panjika, New_Entry2)

		if(length(tithi_d) == 8){
			kshaya_tithi <- Tithis[tithi_d[5]]
			kshaya_tithi_change <- paste(tithi_d[6], str2, tithi_d[7], str2, tithi_d[8])

			New_Entry2 <- c(str3, str3, str3, str3, kshaya_tithi, kshaya_tithi_change, str3, str3, str3, str3)
			text_panjika <- rbind(text_panjika, New_Entry2)
		}

		if(length(nakshatra_d) == 8){
			kshaya_nakshatra <- Nakshatras[nakshatra_d[5]]
			kshaya_nakshatra_change <- paste(nakshatra_d[6], str2, nakshatra_d[7], str2, nakshatra_d[8])

			New_Entry2 <- c(str3, str3, str3, str3, str3, str3, kshaya_nakshatra, kshaya_nakshatra_change, str3, str3)
			text_panjika <- rbind(text_panjika, New_Entry2)
		}
	}

	return(text_panjika)
}

get_panjika_arunodaya <- function (start_date_jd, end_date_jd, place){

	text_panjika = data.frame(matrix( 
  					vector(), 0, 11, dimnames=list(c(), c("Date", "Vara", "Sunrise", "Arunodaya","Sunset", "Tithi", "Tithi_Change", 
  														 "Nakshatra", "Nakshatra_Change", "Paksha", "Amanta_Masa"))), 
                	stringsAsFactors=F)


	for (jd in start_date_jd:end_date_jd){

		sunrise_d <- sunrise(jd,place)[2:4]
		arunodaya_sec <- to_sec(sunrise_d) - two_muhurtas
		arunodaya_d <- to_hms(arunodaya_sec)
		sunset_d <- sunset(jd,place)[2:4]
		tithi_d <- tithi(jd,place)
		nakshatra_d <- nakshatra(jd,place)
		amanta_masa <- get_masa_name(jd,place)
		vara <- get_vaara_name(jd)

		gc_date <- jd_to_gregorian(jd)
		date1 <- paste(gc_date[3], str1, gc_date[2], str1, gc_date[1])
		sunrise1 <- paste(sunrise_d[1], str2, sunrise_d[2], str2, sunrise_d[3])
		arunodaya1 <- paste(arunodaya_d[1], str2, arunodaya_d[2], str2, arunodaya_d[3])
		sunset1 <- paste(sunset_d[1], str2, sunset_d[2], str2, sunset_d[3])
		tithi1 <- Tithis[tithi_d[1]]
		tithi_change <- paste(tithi_d[2], str2, tithi_d[3], str2, tithi_d[4])
		nakshatra1 <- Nakshatras[nakshatra_d[1]]
		nakshatra_change <- paste(nakshatra_d[2], str2, nakshatra_d[3], str2, nakshatra_d[4])
		paksha <- Pakshas[tithi_d[1]]

		New_Entry2 <- c(date1, vara, sunrise1, arunodaya1, sunset1, tithi1, tithi_change, nakshatra1, nakshatra_change, paksha, amanta_masa)
		text_panjika <- rbind(text_panjika, New_Entry2)
	}

	return(text_panjika)
}

get_panjika_12hr <- function (start_date_jd, end_date_jd, place){

	text_panjika = data.frame(matrix( 
  					vector(), 0, 13, dimnames=list(c(), c("Amanta_Masa", "Paksha", "Date", "Vara", "Tithi", "Tithi_DIRA","Tithi_Change", "Nakshatra", "Nakshatra_DIRA", 
  														 "Nakshatra_Change", "Sunrise", "Sunset", "Arunodaya"))), 
                	stringsAsFactors=F)

	for (jd in start_date_jd:end_date_jd){

		sunrise_d <- sunrise(jd,place)[2:4]
		sunrise_d_sec <- to_sec(sunrise_d)
		arunodaya_sec <- sunrise_d_sec - 2*48*60
		arunodaya_d <- to_hms(arunodaya_sec)
		sunset_d <- sunset(jd,place)[2:4]
		sunset_d_sec <- to_sec(sunset_d)
		sunset_d2 <- to_hms(sunset_d_sec - 12*60*60)
		tithi_d <- tithi(jd,place)
		tithi_d_sec <- to_sec(tithi_d[2:4])
		nakshatra_d <- nakshatra(jd,place)
		nakshatra_d_sec <- to_sec(nakshatra_d[2:4])
		amanta_masa <- get_masa_name(jd,place)
		vara <- get_vaara_name(jd)


		gc_date <- jd_to_gregorian(jd)
		date1 <- paste(gc_date[3], str1, gc_date[2], str1, gc_date[1])
		sunrise1 <- paste(sunrise_d[1], str2, sunrise_d[2])
		arunodaya1 <- paste(arunodaya_d[1], str2, arunodaya_d[2], str2, arunodaya_d[3])
		sunset1 <- paste(sunset_d2[1], str2, sunset_d2[2])
		tithi1 <- Tithis[tithi_d[1]]

		if (tithi_d_sec >= sunrise_d_sec & tithi_d_sec <= sunset_d_sec) {
  			tithi1_dira <- "Di"
		} else {
  			tithi1_dira <- "Ra"
		}

		tithi_d2 <- to_hms(norm_time(tithi_d_sec))

		tithi_change <- paste(tithi_d2[1], str2, tithi_d2[2])
		nakshatra1 <- Nakshatras[nakshatra_d[1]]

		if (nakshatra_d_sec >= sunrise_d_sec & nakshatra_d_sec <= sunset_d_sec) {
  			nakshatra_dira <- "Di"
		} else {
  			nakshatra_dira <- "Ra"
		}

		if (nakshatra_d_sec >= 13*60*60 & nakshatra_d_sec < 25*60*60){
			nakshatra_d2 <- to_hms(nakshatra_d_sec - 12*60*60)
		} else if (nakshatra_d_sec < 60*60) {
			nakshatra_d2 <- to_hms(nakshatra_d_sec + 12*60*60)
		} else if (nakshatra_d_sec >= 25*60*60) {
			nakshatra_d2 <- to_hms(nakshatra_d_sec - 24*60*60)
		} else {
			nakshatra_d2 <- to_hms(nakshatra_d_sec)
		}

		nakshatra_change <- paste(nakshatra_d2[1], str2, nakshatra_d2[2])
		paksha <- Pakshas[tithi_d[1]]

#		New_Entry2 <- c(date1, vara, sunrise1, arunodaya1, sunset1, tithi1, tithi_change, nakshatra1, nakshatra_change, paksha, amanta_masa)
		New_Entry2 <- c(amanta_masa, paksha, date1, vara, tithi1, tithi1_dira, tithi_change, nakshatra1, nakshatra_dira, nakshatra_change, sunrise1, sunset1, arunodaya1)
		text_panjika <- rbind(text_panjika, New_Entry2)
	}

	return(text_panjika)
}

#* @post /generate-panjika
function(lat, lon, tz, start_dd, start_mm, start_yyyy, end_dd, end_mm, end_yyyy, style, res) {

  place      <- c(as.numeric(lat), as.numeric(lon), as.numeric(tz))
  start_date <- gregorian_to_jd(as.integer(start_dd), as.integer(start_mm), as.integer(start_yyyy))
  end_date   <- gregorian_to_jd(as.integer(end_dd), as.integer(end_mm), as.integer(end_yyyy))

  if (style == "24hr") {
    panjika <- get_panjika_vanilla(start_date, end_date, place)
    titles <- c("Dinanka", "Vara", "Suryodaya", "Suryasta", "Tithi", "Tithi_Change", "Nakshatra", 
			"Nakshatra_Change", "Paksha", "Amanta_Masa")
	for (i in 1:10) {
	colnames(panjika)[i] <- titles[i]
	}

  } else if (style == "24hr_kshaya") {
    panjika <- get_panjika_kshaya(start_date, end_date, place)
    titles <- c("Dinanka", "Vara", "Suryodaya", "Suryasta", "Tithi", "Tithi_Change", "Nakshatra", 
			"Nakshatra_Change", "Paksha", "Amanta_Masa")
	for (i in 1:10) {
		colnames(panjika)[i] <- titles[i]
	}

  } else if (style == "24hr_arunodaya") {
    panjika <- get_panjika_arunodaya(start_date, end_date, place)
    titles <- c("Dinanka", "Vara", "Suryodaya", "Arunodaya", "Suryasta", "Tithi", "Tithi_Change", "Nakshatra", 
			"Nakshatra_Change", "Paksha", "Amanta_Masa")
	for (i in 1:11) {
		colnames(panjika)[i] <- titles[i]
	}

  } else if (style == "12hr") {
    panjika <- get_panjika_12hr(start_date, end_date, place)
    titles <- c("Amanta Masa", "Paksha", "Dinanka", "Vara", "Tithi", "Di/Ra", "Samaya", "Nakshatra", "Di/Ra", "Samaya", 
			"Suryodaya", "Suryasta", "Arunodaya")
	for (i in 1:13) {
		colnames(panjika)[i] <- titles[i]
	}

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

