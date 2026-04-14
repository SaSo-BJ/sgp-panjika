/*
 * Śrī Gadādhara Parivāra Panjikā — Location Data
 *
 * Sources: latlong.net, mapsofindia.com, indiastatdistricts.com (all verified)
 *
 * Format: { name, lat, lon, tz }
 *   lat — latitude in decimal degrees (positive = North)
 *   lon — longitude in decimal degrees (positive = East)
 *   tz  — UTC offset in hours (e.g. India Standard Time = +5.5)
 *
 * IMPORTANT NOTE FOR FOREIGN LOCATIONS:
 * Several countries observe Daylight Saving Time (DST), which shifts the UTC
 * offset by +1 hour for part of the year. For such cities, TWO entries are
 * provided — one for standard time and one for DST. Please select the entry
 * that matches the time of year covered by your requested date range.
 *   USA DST (EDT/CDT/PDT) — second Sunday in March to first Sunday in November
 *   UK  BST               — last Sunday in March to last Sunday in October
 *   EU  CEST              — last Sunday in March to last Sunday in October
 *   Australia AEDT        — first Sunday in October to first Sunday in April
 *   New Zealand NZDT      — last Sunday in September to first Sunday in April
 *
 * All India entries use IST (UTC +5.5). India does not observe DST.
 */

const LOCATIONS = [

  // ─────────────────────────────────────────────────────────────
  // INDIA — Vaishnava Pilgrimage Sites (Braja Mandala)
  // ─────────────────────────────────────────────────────────────
  { name: "Vrindavan, UP, India",          lat: 27.5650, lon: 77.6593, tz: 5.5 },
  { name: "Mathura, UP, India",            lat: 27.4673, lon: 77.6833, tz: 5.5 },
  { name: "Govardhan, UP, India",          lat: 27.4990, lon: 77.4670, tz: 5.5 },
  { name: "Barsana, UP, India",            lat: 27.6490, lon: 77.3690, tz: 5.5 },
  { name: "Gokul, UP, India",              lat: 27.4590, lon: 77.7200, tz: 5.5 },
  { name: "Nandagram, UP, India",          lat: 27.5500, lon: 77.4670, tz: 5.5 },

  // ─────────────────────────────────────────────────────────────
  // INDIA — Vaishnava Pilgrimage Sites (Navadvipa / Gaura Mandala)
  // ─────────────────────────────────────────────────────────────
  { name: "Mayapur, West Bengal, India",   lat: 23.4232, lon: 88.3883, tz: 5.5 },
  { name: "Navadvipa, West Bengal, India", lat: 23.4000, lon: 88.3830, tz: 5.5 },
  { name: "Shantipur, West Bengal, India", lat: 23.2330, lon: 88.4830, tz: 5.5 },
  { name: "Bishnupur, West Bengal, India", lat: 23.0830, lon: 87.3830, tz: 5.5 },

  // ─────────────────────────────────────────────────────────────
  // INDIA — Other Major Pilgrimage Sites
  // ─────────────────────────────────────────────────────────────
  { name: "Puri, Odisha, India",           lat: 19.8000, lon: 85.8670, tz: 5.5 },
  { name: "Ayodhya, UP, India",            lat: 26.8000, lon: 82.2330, tz: 5.5 },
  { name: "Varanasi, UP, India",           lat: 25.3217, lon: 82.9873, tz: 5.5 },
  { name: "Prayagraj, UP, India",          lat: 25.4670, lon: 81.9000, tz: 5.5 },
  { name: "Haridwar, Uttarakhand, India",  lat: 29.9457, lon: 78.1642, tz: 5.5 },
  { name: "Rishikesh, Uttarakhand, India", lat: 30.0869, lon: 78.2676, tz: 5.5 },
  { name: "Kurukshetra, Haryana, India",   lat: 29.9695, lon: 76.8783, tz: 5.5 },
  { name: "Dwarka, Gujarat, India",        lat: 22.2442, lon: 68.9685, tz: 5.5 },
  { name: "Tirupati, AP, India",           lat: 13.6288, lon: 79.4192, tz: 5.5 },
  { name: "Udupi, Karnataka, India",       lat: 13.3409, lon: 74.7421, tz: 5.5 },
  { name: "Kanchipuram, TN, India",        lat: 12.8185, lon: 79.6947, tz: 5.5 },
  { name: "Ujjain, MP, India",             lat: 23.1765, lon: 75.7885, tz: 5.5 },
  { name: "Tiruvannamalai, TN, India",     lat: 12.2253, lon: 79.0747, tz: 5.5 },
  { name: "Pushkar, Rajasthan, India",     lat: 26.4899, lon: 74.5518, tz: 5.5 },
  { name: "Pandharpur, Maharashtra, India",lat: 17.6804, lon: 75.3322, tz: 5.5 },
  { name: "Bodh Gaya, Bihar, India",       lat: 24.6961, lon: 84.9914, tz: 5.5 },

  // ─────────────────────────────────────────────────────────────
  // INDIA — Major Cities (North)
  // ─────────────────────────────────────────────────────────────
  { name: "New Delhi, India",              lat: 28.6139, lon: 77.2090, tz: 5.5 },
  { name: "Gurugram, Haryana, India",      lat: 28.4595, lon: 77.0266, tz: 5.5 },
  { name: "Noida, UP, India",              lat: 28.5355, lon: 77.3910, tz: 5.5 },
  { name: "Ghaziabad, UP, India",          lat: 28.6670, lon: 77.4670, tz: 5.5 },
  { name: "Meerut, UP, India",             lat: 29.0170, lon: 77.7500, tz: 5.5 },
  { name: "Agra, UP, India",               lat: 27.1767, lon: 78.0833, tz: 5.5 },
  { name: "Lucknow, UP, India",            lat: 26.9170, lon: 80.9830, tz: 5.5 },
  { name: "Kanpur, UP, India",             lat: 26.4670, lon: 80.4000, tz: 5.5 },
  { name: "Gorakhpur, UP, India",          lat: 26.7500, lon: 83.4000, tz: 5.5 },
  { name: "Bareilly, UP, India",           lat: 28.3670, lon: 79.4500, tz: 5.5 },
  { name: "Chandigarh, India",             lat: 30.7333, lon: 76.7794, tz: 5.5 },
  { name: "Amritsar, Punjab, India",       lat: 31.6340, lon: 74.8723, tz: 5.5 },
  { name: "Jammu, J&K, India",             lat: 32.7357, lon: 74.8691, tz: 5.5 },
  { name: "Srinagar, J&K, India",          lat: 34.0837, lon: 74.7973, tz: 5.5 },
  { name: "Shimla, HP, India",             lat: 31.1048, lon: 77.1734, tz: 5.5 },
  { name: "Dehradun, Uttarakhand, India",  lat: 30.3165, lon: 78.0322, tz: 5.5 },
  { name: "Jaipur, Rajasthan, India",      lat: 26.9124, lon: 75.7873, tz: 5.5 },
  { name: "Udaipur, Rajasthan, India",     lat: 24.5854, lon: 73.7125, tz: 5.5 },
  { name: "Jodhpur, Rajasthan, India",     lat: 26.2389, lon: 73.0243, tz: 5.5 },

  // ─────────────────────────────────────────────────────────────
  // INDIA — Major Cities (East)
  // ─────────────────────────────────────────────────────────────
  { name: "Kolkata, West Bengal, India",   lat: 22.5726, lon: 88.3639, tz: 5.5 },
  { name: "Howrah, West Bengal, India",    lat: 22.5830, lon: 88.3830, tz: 5.5 },
  { name: "Murshidabad, WB, India",        lat: 24.1830, lon: 88.3170, tz: 5.5 },
  { name: "Siliguri, West Bengal, India",  lat: 26.7000, lon: 88.4170, tz: 5.5 },
  { name: "Cooch Behar, WB, India",        lat: 26.3330, lon: 89.4830, tz: 5.5 },
  { name: "Darjeeling, WB, India",         lat: 27.0500, lon: 88.2667, tz: 5.5 },
  { name: "Bhubaneswar, Odisha, India",    lat: 20.2961, lon: 85.8245, tz: 5.5 },
  { name: "Cuttack, Odisha, India",        lat: 20.4670, lon: 85.9000, tz: 5.5 },
  { name: "Patna, Bihar, India",           lat: 25.5941, lon: 85.1376, tz: 5.5 },
  { name: "Gaya, Bihar, India",            lat: 24.7961, lon: 85.0002, tz: 5.5 },
  { name: "Ranchi, Jharkhand, India",      lat: 23.3441, lon: 85.3096, tz: 5.5 },
  { name: "Jamshedpur, Jharkhand, India",  lat: 22.8046, lon: 86.2029, tz: 5.5 },
  { name: "Guwahati, Assam, India",        lat: 26.1445, lon: 91.7362, tz: 5.5 },
  { name: "Agartala, Tripura, India",      lat: 23.8315, lon: 91.2868, tz: 5.5 },
  { name: "Imphal, Manipur, India",        lat: 24.8170, lon: 93.9368, tz: 5.5 },
  { name: "Port Blair, Andaman, India",    lat: 11.6234, lon: 92.7265, tz: 5.5 },

  // ─────────────────────────────────────────────────────────────
  // INDIA — Major Cities (West)
  // ─────────────────────────────────────────────────────────────
  { name: "Mumbai, Maharashtra, India",    lat: 19.0760, lon: 72.8777, tz: 5.5 },
  { name: "Pune, Maharashtra, India",      lat: 18.5204, lon: 73.8567, tz: 5.5 },
  { name: "Nagpur, Maharashtra, India",    lat: 21.1458, lon: 79.0882, tz: 5.5 },
  { name: "Nashik, Maharashtra, India",    lat: 19.9975, lon: 73.7898, tz: 5.5 },
  { name: "Aurangabad, Maharashtra, India",lat: 19.8762, lon: 75.3433, tz: 5.5 },
  { name: "Kolhapur, Maharashtra, India",  lat: 16.7050, lon: 74.2433, tz: 5.5 },
  { name: "Ahmedabad, Gujarat, India",     lat: 23.0225, lon: 72.5714, tz: 5.5 },
  { name: "Surat, Gujarat, India",         lat: 21.1702, lon: 72.8311, tz: 5.5 },
  { name: "Vadodara, Gujarat, India",      lat: 22.3072, lon: 73.1812, tz: 5.5 },
  { name: "Raipur, Chhattisgarh, India",   lat: 21.2500, lon: 81.6300, tz: 5.5 },
  { name: "Bhopal, MP, India",             lat: 23.2599, lon: 77.4126, tz: 5.5 },
  { name: "Indore, MP, India",             lat: 22.7196, lon: 75.8577, tz: 5.5 },
  { name: "Gwalior, MP, India",            lat: 26.2183, lon: 78.1828, tz: 5.5 },
  { name: "Jabalpur, MP, India",           lat: 23.1815, lon: 79.9864, tz: 5.5 },
  { name: "Panaji, Goa, India",            lat: 15.4989, lon: 73.8278, tz: 5.5 },

  // ─────────────────────────────────────────────────────────────
  // INDIA — Major Cities (South)
  // ─────────────────────────────────────────────────────────────
  { name: "Bengaluru, Karnataka, India",   lat: 12.9716, lon: 77.5946, tz: 5.5 },
  { name: "Mysuru, Karnataka, India",      lat: 12.2958, lon: 76.6394, tz: 5.5 },
  { name: "Hubballi, Karnataka, India",    lat: 15.3647, lon: 75.1240, tz: 5.5 },
  { name: "Mangaluru, Karnataka, India",   lat: 12.9141, lon: 74.8560, tz: 5.5 },
  { name: "Hyderabad, Telangana, India",   lat: 17.3850, lon: 78.4867, tz: 5.5 },
  { name: "Visakhapatnam, AP, India",      lat: 17.6868, lon: 83.2185, tz: 5.5 },
  { name: "Vijayawada, AP, India",         lat: 16.5062, lon: 80.6480, tz: 5.5 },
  { name: "Chennai, Tamil Nadu, India",    lat: 13.0827, lon: 80.2707, tz: 5.5 },
  { name: "Madurai, Tamil Nadu, India",    lat:  9.9252, lon: 78.1198, tz: 5.5 },
  { name: "Coimbatore, Tamil Nadu, India", lat: 11.0168, lon: 76.9558, tz: 5.5 },
  { name: "Pondicherry, India",            lat: 11.9416, lon: 79.8083, tz: 5.5 },
  { name: "Thiruvananthapuram, Kerala, India", lat: 8.5241, lon: 76.9366, tz: 5.5 },
  { name: "Kochi, Kerala, India",          lat:  9.9312, lon: 76.2673, tz: 5.5 },
  { name: "Kozhikode, Kerala, India",      lat: 11.2588, lon: 75.7804, tz: 5.5 },
  { name: "Thrissur, Kerala, India",       lat: 10.5276, lon: 76.2144, tz: 5.5 },

  // ─────────────────────────────────────────────────────────────
  // FOREIGN — Gulf (no DST, fixed UTC offset)
  // ─────────────────────────────────────────────────────────────
  { name: "Dubai, UAE (UTC+4)",            lat: 25.2048, lon: 55.2708, tz: 4.0 },
  { name: "Abu Dhabi, UAE (UTC+4)",        lat: 24.4539, lon: 54.3773, tz: 4.0 },
  { name: "Sharjah, UAE (UTC+4)",          lat: 25.3463, lon: 55.4209, tz: 4.0 },
  { name: "Muscat, Oman (UTC+4)",          lat: 23.5880, lon: 58.3829, tz: 4.0 },
  { name: "Riyadh, Saudi Arabia (UTC+3)",  lat: 24.6877, lon: 46.7219, tz: 3.0 },
  { name: "Jeddah, Saudi Arabia (UTC+3)",  lat: 21.4858, lon: 39.1925, tz: 3.0 },
  { name: "Kuwait City, Kuwait (UTC+3)",   lat: 29.3759, lon: 47.9774, tz: 3.0 },
  { name: "Doha, Qatar (UTC+3)",           lat: 25.2854, lon: 51.5310, tz: 3.0 },
  { name: "Manama, Bahrain (UTC+3)",       lat: 26.2235, lon: 50.5876, tz: 3.0 },

  // ─────────────────────────────────────────────────────────────
  // FOREIGN — Africa & Indian Ocean (no DST)
  // ─────────────────────────────────────────────────────────────
  { name: "Port Louis, Mauritius (UTC+4)", lat: -20.1609, lon: 57.4990, tz: 4.0 },
  { name: "Nairobi, Kenya (UTC+3)",        lat:  -1.2921, lon: 36.8219, tz: 3.0 },
  { name: "Johannesburg, South Africa (UTC+2)", lat: -26.2041, lon: 28.0473, tz: 2.0 },
  { name: "Durban, South Africa (UTC+2)",  lat: -29.8587, lon: 31.0218, tz: 2.0 },

  // ─────────────────────────────────────────────────────────────
  // FOREIGN — Asia & Pacific (no DST, except New Zealand & Australia)
  // ─────────────────────────────────────────────────────────────
  { name: "Singapore (UTC+8)",             lat:  1.3521, lon: 103.8198, tz: 8.0 },
  { name: "Kuala Lumpur, Malaysia (UTC+8)",lat:  3.1390, lon: 101.6869, tz: 8.0 },
  { name: "Hong Kong (UTC+8)",             lat: 22.3193, lon: 114.1694, tz: 8.0 },

  // Australia observes DST in southern hemisphere summer (Oct–Apr)
  { name: "Sydney, Australia — AEST, Apr–Oct (UTC+10)",  lat: -33.8688, lon: 151.2093, tz: 10.0 },
  { name: "Sydney, Australia — AEDT, Oct–Apr (UTC+11)",  lat: -33.8688, lon: 151.2093, tz: 11.0 },
  { name: "Melbourne, Australia — AEST, Apr–Oct (UTC+10)",lat: -37.8136, lon: 144.9631, tz: 10.0 },
  { name: "Melbourne, Australia — AEDT, Oct–Apr (UTC+11)",lat: -37.8136, lon: 144.9631, tz: 11.0 },

  // New Zealand observes DST (Sep–Apr)
  { name: "Auckland, New Zealand — NZST, Apr–Sep (UTC+12)",  lat: -36.8485, lon: 174.7633, tz: 12.0 },
  { name: "Auckland, New Zealand — NZDT, Sep–Apr (UTC+13)",  lat: -36.8485, lon: 174.7633, tz: 13.0 },

  // ─────────────────────────────────────────────────────────────
  // FOREIGN — Europe (DST applies: CET/BST in summer)
  // ─────────────────────────────────────────────────────────────
  { name: "London, UK — GMT, Oct–Mar (UTC+0)",   lat: 51.5074, lon: -0.1278, tz: 0.0 },
  { name: "London, UK — BST, Mar–Oct (UTC+1)",   lat: 51.5074, lon: -0.1278, tz: 1.0 },
  { name: "Amsterdam, Netherlands — CET, Oct–Mar (UTC+1)",  lat: 52.3676, lon: 4.9041, tz: 1.0 },
  { name: "Amsterdam, Netherlands — CEST, Mar–Oct (UTC+2)", lat: 52.3676, lon: 4.9041, tz: 2.0 },

  // ─────────────────────────────────────────────────────────────
  // FOREIGN — North America (DST applies: EDT/CDT/PDT in summer)
  // ─────────────────────────────────────────────────────────────
  { name: "New York, USA — EST, Nov–Mar (UTC-5)",   lat: 40.7128, lon: -74.0060, tz: -5.0 },
  { name: "New York, USA — EDT, Mar–Nov (UTC-4)",   lat: 40.7128, lon: -74.0060, tz: -4.0 },
  { name: "Chicago, USA — CST, Nov–Mar (UTC-6)",    lat: 41.8781, lon: -87.6298, tz: -6.0 },
  { name: "Chicago, USA — CDT, Mar–Nov (UTC-5)",    lat: 41.8781, lon: -87.6298, tz: -5.0 },
  { name: "Houston, USA — CST, Nov–Mar (UTC-6)",    lat: 29.7604, lon: -95.3698, tz: -6.0 },
  { name: "Houston, USA — CDT, Mar–Nov (UTC-5)",    lat: 29.7604, lon: -95.3698, tz: -5.0 },
  { name: "San Francisco, USA — PST, Nov–Mar (UTC-8)", lat: 37.7749, lon: -122.4194, tz: -8.0 },
  { name: "San Francisco, USA — PDT, Mar–Nov (UTC-7)", lat: 37.7749, lon: -122.4194, tz: -7.0 },
  { name: "Toronto, Canada — EST, Nov–Mar (UTC-5)", lat: 43.6532, lon: -79.3832, tz: -5.0 },
  { name: "Toronto, Canada — EDT, Mar–Nov (UTC-4)", lat: 43.6532, lon: -79.3832, tz: -4.0 },
  { name: "Vancouver, Canada — PST, Nov–Mar (UTC-8)", lat: 49.2827, lon: -123.1207, tz: -8.0 },
  { name: "Vancouver, Canada — PDT, Mar–Nov (UTC-7)", lat: 49.2827, lon: -123.1207, tz: -7.0 },

];

/*
 * Total entries: 91 India + 37 foreign (including DST pairs) = 128 entries
 *
 * Usage in frontend autocomplete:
 *   Filter LOCATIONS by matching the user's typed text against entry.name
 *   On selection: silently extract entry.lat, entry.lon, entry.tz
 *   Pass these to the Plumber backend as: lat, lon, tz
 */
