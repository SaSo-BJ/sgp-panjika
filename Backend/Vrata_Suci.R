#* @get /health
function() {
  list(status = "ok")
}


# Arunodaya is approximated by subtracting 96 mins from Suryodaya
# Vrata_7 has apparently swapped Jayanti & Jaya in B_Vrata_Comment. Corrected here in Vrata_8
# End times of Tithis & Nakshatras considered here instead of durations as in Vrata_8


# invoking the "already installed" VedicDateTime package
library(VedicDateTime)

#tithi_id 1 is for the shukla paksha pratipada -> Following the Amanta calendar

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

A_Test_Scores <- c(64,32,16,4,2,1,66,65,40,34,33,44,37,24,28,18,17,5,8,0)

A_Vrata_Dina <- c("dina-2 (dvadashi)", "dina-2 (dvadashi)", "dina-1 (ekadashi)", "dina-1 (ekadashi)", 
	"dina-1 (ekadashi)", "dina-2 (dvadashi)", "dina-2 (dvadashi)", "dina-2 (dvadashi)", "dina-2 (ekadashi)",
	"dina-2 (dvadashi)", "dina-2 (dvadashi)", "dina-2 (ekadashi)", "dina-2 (ekadashi)", "dina-2 (ekadashi)",
	"dina-2 (ekadashi)", "dina-2 (dvadashi)", "dina-1 (ekadashi)", "dina-1 (ekadashi)", "dina-2 (ekadashi)",
	"dina-1 (ekadashi)")

A_Parana_Dina <- c("dina-3 (trayodashi)", "dina-3 (trayodashi)", "dina-2 (dvadashi)", "dina-2 (trayodashi)",
	"dina-2 (dvadashi)", "dina-3 (trayodashi)", "dina-3 (dvadashi)", "dina-3 (trayodashi)", "dina-3 (dvadashi)",
	"dina-3 (trayodashi)", "dina-3 (trayodashi)", "dina-3 (trayodashi)", "dina-3 (trayodashi)", "dina-3 (dvadashi)",
	"dina-3 (trayodashi)", "dina-3 (dvadashi)", "dina-2 (dvadashi)", "dina-2 (trayodashi)", "dina-3 (dvadashi)",
	"dina-2 (dvadashi)")

A_Vrata_Comment <- c("ekadashi kshaya", "dashami-viddha ekadashi", "-", "trisparsha-mahadvadashi", "-",
	"pakshavardhini-mahadvadashi", "-", "ekadashi kshaya & pakshavardhini-mahadvadashi", "dashami-viddha ekadashi",
	"dashami-viddha ekadashi", "dashami-viddha ekadashi", "dashami-viddha ekadashi", "dashami-viddha ekadashi", "-",
	"unmilani-mahadvadashi", "vanjuli-mahadvadashi", "-", "trisparsha-mahadvadashi", "-", "normal")

A_Description <- c("ekadashi-kshaya", "dashami-viddha ekadashi", "sampurna-ekadashi", "dvadashi kshaya", 
	"dvadashi vriddhi", "amavasya or purnima vriddhi", "ekadashi-kshaya, dvadashi vriddhi", 
	"ekadashi-kshaya, amavasya or purnima vriddhi",
	"dashami-viddha ekadashi, ekadashi-vriddhi",
	"dashami-viddha ekadashi, dvadashi vriddhi",
	"dashami-viddha ekadashi, amavasya or purnima vriddhi",
	"dashami-viddha ekadashi, ekadashi-vriddhi, dvadashi kshaya",
	"dashami-viddha ekadashi, dvadashi kshaya, amavasya or purnima vriddhi",
	"sampurna-ekadashi, ekadashi-vriddhi",
	"sampurna-ekadashi, ekadashi-vriddhi, dvadashi kshaya",
	"sampurna-ekadashi, dvadashi vriddhi",
	"sampurna-ekadashi, amavasya or purnima vriddhi",
	"dvadashi kshaya, amavasya or purnima vriddhi",
	"ekadashi vriddhi",
	"normal")

B_Values <- c(4,22,7,8,0)

B_Vrata_Dina <- c("dina-2 (dvadashi)", "dina-2 (dvadashi)", "dina-2 (dvadashi)", "dina-2 (dvadashi)", "-")

B_Parana_Dina <- c("dina-3 (trayodashi)", "dina-3 (trayodashi)", "dina-3 (trayodashi)", "dina-3 (trayodashi)", "-")

B_Vrata_Comment <- c("jayanti mahadvadashi", "vijaya mahadvadashi", "jaya mahadvadashi", 
	"papanashini mahadvadashi", "normal")

names(A_Vrata_Dina) <- A_Test_Scores
names(A_Parana_Dina) <- A_Test_Scores
names(A_Vrata_Comment) <- A_Test_Scores
names(A_Description) <- A_Test_Scores

names(B_Vrata_Dina) <- B_Values
names(B_Parana_Dina) <- B_Values
names(B_Vrata_Comment) <- B_Values

A_Test_Flags <- c(0,0,0,0,0,0,0)
B_Test_Flag <- 0 # 0 - none. 7 - Punarvasu/Jaya 22 - Shravana/Vijaya 4 - Rohini/Jayanti 8 - Pushya/Papanashini.
N_Test_Flags <- c(0,0,0)
U_Flag <- 0

A_Bin_Score <- 0

str1 <- "-"
str2 <- ":"
weights <- c(64,32,16,8,4,2,1)


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

one_day_sec <- 24*60*60
two_muhurtas <- 2*48*60

get_basic_panjika <- function (start_date_jd, end_date_jd, place){

	df_col <- 8

	num_panjika = data.frame(matrix( 
  					vector(), 0, df_col, dimnames=list(c(), 
  						c("Julian_Date", "Sunrise_sec", "Arunodaya_sec", "Sunset_sec", "Tithi", 
  							"Tithi_Change_Time_sec", "Nakshatra", "Nakshatra_Change_Time_sec"))), 
                	stringsAsFactors=F)


	for (jd in start_date_jd:end_date_jd){

		sunrise_d <- sunrise(jd,place)[2:4]
		sunrise_sec <- to_sec(sunrise_d)
		arunodaya_sec <- sunrise_sec - two_muhurtas
		sunset_d <- sunset(jd,place)[2:4]
		sunset_sec <- to_sec(sunset_d)
		tithi_d <- tithi(jd,place)
		tithi_no <- tithi_d[1]
		tithi_change_time_sec <- to_sec(tithi_d[2:4])
		nakshatra_d <- nakshatra(jd,place)
		nakshatra_no <- nakshatra_d[1]
		nak_change_time_sec <- to_sec(nakshatra_d[2:4])


		New_Entry <- c(jd, sunrise_sec, arunodaya_sec, sunset_sec, 
			tithi_no, tithi_change_time_sec, nakshatra_no, nak_change_time_sec)
		num_panjika <- rbind(num_panjika, New_Entry)

		if(length(tithi_d) == 8){
			
			kshaya_tithi_change <- to_sec(tithi_d[6:8])

			New_Entry2 <- c(jd, sunrise_sec, arunodaya_sec, sunset_sec, 
			tithi_d[5], kshaya_tithi_change, nakshatra_no, nak_change_time_sec)
			num_panjika <- rbind(num_panjika, New_Entry2)
		}
	}

	return(num_panjika)
}

#kshaya tests
test_A15 <- function(row){
	if(n_panjika[row, "Julian_Date"] == n_panjika[row - 1, "Julian_Date"]){
		return(1)
	} else {
		return(0)
	}
}

test_A2 <- function(row){
	if (n_panjika[row - 1, "Tithi_Change_Time_sec"] >= n_panjika[row, "Arunodaya_sec"] + one_day_sec){
		return(1)
	} else {
		return(0)
	}
}

test_A3 <- function(row){
	if (n_panjika[row, "Tithi_Change_Time_sec"] >= n_panjika[row + 1, "Arunodaya_sec"] + one_day_sec){
		return(1)
	} else {
		return(0)
	}
}

#vriddhi tests
test_A467 <- function(row){
	if(n_panjika[row, "Tithi"] == n_panjika[row + 1, "Tithi"]){
		return(1)
	} else {
		return(0)
	}
}

test_N2 <- function(row){
	# nakshatra ends after the tithi

	if (n_panjika[row, "Nakshatra_Change_Time_sec"] > n_panjika[row, "Tithi_Change_Time_sec"]) {
		return(1)
	} else {
		return (0)
	}
}

test_N3 <- function(row){
	# dwadashi ends after suryasta
	if (n_panjika[row, "Tithi_Change_Time_sec"] > n_panjika[row, "Sunset_sec"]){
		return(1)
	} else {
		return(0)
	}
}

find_vratas <- function(){

	vrata_df = data.frame(matrix( 
  					vector(), 0, 23, dimnames=list(c(), 
  						c("Paksha_Number", "Date", "Paksha", 
  							"A1", "A2", "A3", "A4", "A5", "A6", "A7", "A_Bin_Score",
  							"N1", "N2", "N3", "U_Flag", "B_Flag",
  							"A_Vrata_Comment", "A_Vrata_Dina", "A_Parana_Dina", "A_Description",
  							"B_Vrata_Comment", "B_Vrata_Dina", "B_Parana_Dina"))), 
                	stringsAsFactors=F)

	paksha_counter <- 1

	# Nakshatra Flags set to 0. 0 - Not Checked. 1 - Present. 2 - Not Present

	for (row in 1:nrow(n_panjika)){

	#	if (tithi == 11) -> start Ekadashi tests A1 to A4

		if(n_panjika[row, "Tithi"] == 11 | n_panjika[row, "Tithi"] == 26) {

		# in case of vriddhi don't repeat tests
			if (A_Test_Flags[4] == 1){
				next
			}

			ek_date <- jd_to_gregorian(n_panjika[row, "Julian_Date"])
			ek_paksha <- Pakshas[n_panjika[row, "Tithi"]]

			A_Test_Flags[1] <- test_A15(row)
			if (A_Test_Flags[1] == 0){

				A_Test_Flags[2] <- test_A2(row)
				if (A_Test_Flags[2] == 0){

					A_Test_Flags[3] <- test_A3(row)

				} 

				A_Test_Flags[4] <- test_A467(row)
#				if (A_Test_Flags[4] == 1){
#						row <- row + 1 # adjusting the iterator for Vriddhi
#				}

			}

			next
		}

	#	if (tithi == 12) -> start Dwadashi tests A5 & A6		

		if(n_panjika[row, "Tithi"] == 12 | n_panjika[row, "Tithi"] == 27) {


		# in case of vriddhi don't repeat tests
			if (A_Test_Flags[6] == 1){
				next
			}

			if (A_Test_Flags[1] != 1){ 			#if ekadashi isn't kshaya

				A_Test_Flags[5] <- test_A15(row)			# check if dwadashi is kshaya
				if (A_Test_Flags[5] == 0){		# if dwadashi isn't kshaya
					A_Test_Flags[6] <- test_A467(row)
				}

			} else {
				A_Test_Flags[6] <- test_A467(row)
			}

#              N-TESTS

			if (n_panjika[row, "Tithi"] == 12 & A_Test_Flags[5] == 0){
				
				if(n_panjika[row, "Nakshatra"] %in% B_Values){
					N_Test_Flags[1] <- 1
					N_Test_Flags[2] <- test_N2(row)
					N_Test_Flags[3] <- test_N3(row)
				} else if (A_Test_Flags[6] == 1) {
					if (n_panjika[row + 1, "Nakshatra"] %in% B_Values){
						N_Test_Flags[1] <- 1
						U_Flag <- 1
						N_Test_Flags[2] <- test_N2(row+1)
						N_Test_Flags[3] <- test_N3(row+1)
					} else{
						next
					}
				} else {
					next
				}


				#N_Test_Flags[2] <- test_N2(row)

				if (N_Test_Flags[2] == 1){
					if (n_panjika[row, "Nakshatra"] == 22 | n_panjika[row+1, "Nakshatra"] == 22){
						B_Test_Flag <- 22
					} else {
						#N_Test_Flags[3] <- test_N3(row)
						if (N_Test_Flags[3] == 1){
							if (n_panjika[row, "Nakshatra"] %in% B_Values){
								B_Test_Flag <- n_panjika[row, "Nakshatra"]
							} else {
								B_Test_Flag <- n_panjika[row + 1, "Nakshatra"]
							}
								
						}
					}
						
				} else {
					next
				}
				

#				a <- !(N_Test_Flags[1] | N_Test_Flags[2])

#				if ( a & A_Test_Flags[6] ){
#					test_NT(row + 1)
#				}

			} else {
				next
			}

#			if (A_Test_Flags[6] == 1){
#				row <- row + 1 # adjusting the iterator for Vriddhi
#			}
		}
		
	#	if (tithi == 15 or 30) -> test A7

		if(n_panjika[row, "Tithi"] == 15 | n_panjika[row, "Tithi"] == 30) {

			if (A_Test_Flags[7] == 1){
				next
			}

			if (A_Test_Flags[6] == 0 & A_Test_Flags[4] == 0){
				A_Test_Flags[7] <- test_A467(row)
#				if (A_Test_Flags[7] == 1){
#						row <- row + 1 # adjusting the iterator for Vriddhi
#					}
			}
			next
		}


	#	if(tithi == 1 or 16) -> 
	#    1. make all the entries
	#    2. reset flags
	#    3. increment paksha

		if (row>1){

			if( (n_panjika[row, "Tithi"] == 1 & n_panjika[row-1, "Tithi"] == 30) | 
				(n_panjika[row, "Tithi"] == 16 & n_panjika[row-1, "Tithi"] == 15) ) {

				# 1. make all entries
				A_Bin_Score <- crossprod(A_Test_Flags,weights)[1]
				A_Bin_Score_String <- as.character(A_Bin_Score)
				B_Test_Flag_String <- as.character(B_Test_Flag)

				# yaha ekadashi ki date aur tithi wagerah alag se note karna padega
				
				date2 <- paste(ek_date[3], str1, ek_date[2], str1, ek_date[1])

				N_Entry <- c(paksha_counter, date2, ek_paksha, A_Test_Flags[1], A_Test_Flags[2], 
					A_Test_Flags[3], A_Test_Flags[4], A_Test_Flags[5], A_Test_Flags[6], A_Test_Flags[7],
					A_Bin_Score, N_Test_Flags[1], N_Test_Flags[2], N_Test_Flags[3],  
					U_Flag, B_Test_Flag, A_Vrata_Comment[[A_Bin_Score_String]], 
					A_Vrata_Dina[[A_Bin_Score_String]], A_Parana_Dina[[A_Bin_Score_String]], 
					A_Description[[A_Bin_Score_String]], B_Vrata_Comment[[B_Test_Flag_String]] ,
					B_Vrata_Dina[[B_Test_Flag_String]], B_Parana_Dina[[B_Test_Flag_String]])

				vrata_df <- rbind(vrata_df, N_Entry)

				# 2. reset flags
				A_Test_Flags <- c(0,0,0,0,0,0,0)
				B_Test_Flag <- 0
				N_Test_Flags <- c(0,0,0)
				U_Flag <- 0
				A_Bin_Score <- 0

				# 3. increment paksha
				paksha_counter <- paksha_counter + 1
			}
		}
	}

	return(vrata_df)
}


#* @post /generate-vrata-suci
function(lat, lon, tz, start_dd, start_mm, start_yyyy, end_dd, end_mm, end_yyyy, res) {

  place      <- c(as.numeric(lat), as.numeric(lon), as.numeric(tz))
  start_date <- gregorian_to_jd(as.integer(start_dd), as.integer(start_mm), as.integer(start_yyyy))
  end_date   <- gregorian_to_jd(as.integer(end_dd), as.integer(end_mm), as.integer(end_yyyy))

  n_panjika <- get_basic_panjika(start_date, end_date, place)
  np_titles <- c("Julian_Date", "Sunrise_sec", "Arunodaya_sec", "Sunset_sec", "Tithi", 
  		"Tithi_Change_Time_sec", "Nakshatra", "Nakshatra_Change_Time_sec")
  np_cols <- 8

  for (i in 1:np_cols) {
	colnames(n_panjika)[i] <- np_titles[i]
  	}

  vrata_table <- find_vratas()
  vt_titles <- c("Paksha_Number", "Around Date", "Paksha", 
  			"A1", "A2", "A3", "A4", "A5", "A6", "A7", "A_Bin_Score",
  			"N1", "N2", "N3", "U_Flag", "B_Flag",
  			"A_Vrata_Comment", "A_Vrata_Dina", "A_Parana_Dina", "A_Description",
  			"B_Vrata_Comment", "B_Vrata_Dina", "B_Parana_Dina")
  vt_cols <- 23

  for (i in 1:vt_cols) {
	colnames(vrata_table)[i] <- vt_titles[i]
  }

  buf <- textConnection("output_text", open = "w")
  write.csv(vrata_table, buf, row.names = FALSE)
  close(buf)
  csv_text_2 <- paste(output_text, collapse = "\n")

  res$setHeader("Content-Type", "text/csv")
  res$setHeader("Content-Disposition", paste0("attachment; filename=vrata_suci", ".csv"))
  return(csv_text_2)
}
