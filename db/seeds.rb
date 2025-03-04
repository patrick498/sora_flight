require 'open-uri'

puts "Cleaning the db...\n"
puts "Destroying Users\n"
User.destroy_all
puts "Users: #{User.count}"

puts "Destroying Flights\n"
Flight.destroy_all
puts "Flights: #{Flight.count}"
puts "############"

puts "Destroying Airline\n"
Airline.destroy_all
puts "Airline: #{Airline.count}"

puts "Destroying Airports\n"
Airport.destroy_all
puts "Airports: #{Airport.count}"

puts "Destroying Aircrafts\n"
Aircraft.destroy_all
puts "Aircrafts: #{Aircraft.count}"



# Add User
puts "creating users..."

User.create!(
  email: "axel.bailleres@sora.com",
  password: "axel12345",
  username: "axel_sora",
)
User.create!(
  email: "yuki.ide@sora.com",
  password: "yuki12345",
  username: "yuki_sora",
)
User.create!(
  email: "yu.sekiguchi@sora.com",
  password: "sekiguchi12345",
  username: "yu_sora",
)
User.create!(
  email: "patrick.pailhes@sora.com",
  password: "patrick12345",
  username: "patrick_sora",
)
User.create!(
  email: "satoshi.tajiri@sora.com",
  password: "satoshi12345",
  username: "ash_sora",
)

puts "#{User.count} users created"
puts "_" * 10

# Add Airline

puts "creating airlines..."

airlines = [
  {"iata": "NH", "icao": "ANA", "name": "All Nippon Airways"},
  {"iata": "JL", "icao": "JAL", "name": "Japan Airlines"},
  {"iata": "BC", "icao": "SKY", "name": "Skymark Airlines"},
  {"iata": "HD", "icao": "ADO", "name": "Air Do"},
  {"iata": "6J", "icao": "SNJ", "name": "Solaseed Air"},
  {"iata": "MM", "icao": "APJ", "name": "Peach Aviation"},
  {"iata": "7G", "icao": "SFJ", "name": "StarFlyer"},
  {"iata": "QF", "icao": "QFA", "name": "Qantas"},
  {"iata": "BA", "icao": "BAW", "name": "British Airways"},
  {"iata": "AF", "icao": "AFR", "name": "Air France"},
  {"iata": "LH", "icao": "DLH", "name": "Lufthansa"},
  {"iata": "KL", "icao": "KLM", "name": "KLM Royal Dutch Airlines"},
  {"iata": "AY", "icao": "FIN", "name": "Finnair"},
  {"iata": "SU", "icao": "AFL", "name": "Aeroflot"},
  {"iata": "CX", "icao": "CPA", "name": "Cathay Pacific"},
  {"iata": "KA", "icao": "HDA", "name": "Hong Kong Airlines"},
  {"iata": "CI", "icao": "CAL", "name": "China Airlines"},
  {"iata": "BR", "icao": "EVA", "name": "EVA Air"},
  {"iata": "MU", "icao": "CES", "name": "China Eastern Airlines"},
  {"iata": "CZ", "icao": "CSN", "name": "China Southern Airlines"},
  {"iata": "CA", "icao": "CCA", "name": "Air China"},
  {"iata": "KE", "icao": "KAL", "name": "Korean Air"},
  {"iata": "SQ", "icao": "SIA", "name": "Singapore Airlines"},
  {"iata": "TG", "icao": "THA", "name": "Thai Airways"},
  {"iata": "VN", "icao": "HVN", "name": "Vietnam Airlines"},
  {"iata": "PR", "icao": "PAL", "name": "Philippine Airlines"},
  {"iata": "MH", "icao": "MAS", "name": "Malaysia Airlines"},
  {"iata": "GA", "icao": "GIA", "name": "Garuda Indonesia"},
  {"iata": "AI", "icao": "AIC", "name": "Air India"},
  {"iata": "DL", "icao": "DAL", "name": "Delta Air Lines"},
  {"iata": "UA", "icao": "UAL", "name": "United Airlines"},
  {"iata": "AA", "icao": "AAL", "name": "American Airlines"},
  {"iata": "AC", "icao": "ACA", "name": "Air Canada"},
  {"iata": "NZ", "icao": "ANZ", "name": "Air New Zealand"},
  {"iata": "EK", "icao": "UAE", "name": "Emirates"},
  {"iata": "EY", "icao": "ETD", "name": "Etihad Airways"},
  {"iata": "QR", "icao": "QTR", "name": "Qatar Airways"},
  {"iata": "AZ", "icao": "AZA", "name": "Alitalia"},
  {"iata": "IB", "icao": "IBE", "name": "Iberia"},
  {"iata": "VA", "icao": "VOZ", "name": "Virgin Australia"},
  {"iata": "IT", "icao": "TTW", "name": "Tigerair Taiwan"},
  {"iata": "FM", "icao": "CSH", "name": "Shanghai Airlines"},
  {"iata": "AM", "icao": "AMX", "name": "Aeromexico"},
  {"iata": "RF", "icao": "AUK", "name": "Aero K"},
  {"iata": "M0", "icao": "MML", "name": "Aero Mongolia"},
  {"iata": "BX", "icao": "ABL", "name": "Air Busan"},
  {"iata": "ZE", "icao": "ESR", "name": "Eastar Jet"},
  {"iata": "TW", "icao": "TWB", "name": "T'way Air"},
  {"iata": "IJ", "icao": "SJO", "name": "Spring Japan"},
  {"iata": "9C", "icao": "CQH", "name": "Spring Airlines"},
  {"iata": "D7", "icao": "XAX", "name": "AirAsia X"},
  {"iata": "UO", "icao": "HKE", "name": "HK Express"},
  {"iata": "VJ", "icao": "VJC", "name": "VietJet Air"},
  {"iata": "IT", "icao": "TTW", "name": "Tigerair Taiwan"},
  {"iata": "HO", "icao": "DKH", "name": "Juneyao Air"},
  {"iata": "FM", "icao": "CSH", "name": "Shanghai Airlines"},
  {"iata": "SK", "icao": "SAS", "name": "Scandinavian Airlines"},
  {"iata": "HU", "icao": "CHH", "name": "Hainan Airlines"},
  {"iata": "GS", "icao": "GCR", "name": "Tianjin Airlines"},
  {"iata": "OZ", "icao": "AAR", "name": "Asiana Airlines"},
  {"iata": "TK", "icao": "THY", "name": "Turkish Airlines"},
  {"iata": "7C", "icao": "JJA", "name": "Jeju Airline"}
]
airlines.each do |airline|
  Airline.create(
    iata: airline[:iata],
    icao: airline[:icao],
    name: airline[:name]
  )
end

puts "#{Airline.count} airlines created"
puts "_" * 10

# Add Airports

puts "creating airports..."

airports =
[
  {"iata": "HND", "icao": "RJTT", "name": "Haneda Airport", "city": "Tokyo", "country": "Japan", "latitude": 35.5494, "longitude": 139.7798},
  {"iata": "NRT", "icao": "RJAA", "name": "Narita International Airport", "city": "Narita", "country": "Japan", "latitude": 35.7647, "longitude": 140.3860},
  {"iata": "CTS", "icao": "RJCC", "name": "New Chitose Airport", "city": "Sapporo", "country": "Japan", "latitude": 42.7752, "longitude": 141.6923},
  {"iata": "KIX", "icao": "RJBB", "name": "Kansai International Airport", "city": "Osaka", "country": "Japan", "latitude": 34.4347, "longitude": 135.2448},
  {"iata": "ITM", "icao": "RJOO", "name": "Osaka International Airport", "city": "Osaka", "country": "Japan", "latitude": 34.7855, "longitude": 135.4382},
  {"iata": "FUK", "icao": "RJFF", "name": "Fukuoka Airport", "city": "Fukuoka", "country": "Japan", "latitude": 33.5859, "longitude": 130.4500},
  {"iata": "OKA", "icao": "ROAH", "name": "Naha Airport", "city": "Naha", "country": "Japan", "latitude": 26.1958, "longitude": 127.6460},
  {"iata": "NGO", "icao": "RJGG", "name": "Chubu Centrair International Airport", "city": "Nagoya", "country": "Japan", "latitude": 34.8583, "longitude": 136.8054},
  {"iata": "SDJ", "icao": "RJSS", "name": "Sendai Airport", "city": "Sendai", "country": "Japan", "latitude": 38.1397, "longitude": 140.9176},
  {"iata": "KOJ", "icao": "RJFK", "name": "Kagoshima Airport", "city": "Kagoshima", "country": "Japan", "latitude": 31.8034, "longitude": 130.7194},
  {"iata": "KMJ", "icao": "RJFT", "name": "Kumamoto Airport", "city": "Kumamoto", "country": "Japan", "latitude": 32.8373, "longitude": 130.8550},
  {"iata": "HIJ", "icao": "RJOA", "name": "Hiroshima Airport", "city": "Hiroshima", "country": "Japan", "latitude": 34.4361, "longitude": 132.9194},
  {"iata": "NGS", "icao": "RJFU", "name": "Nagasaki Airport", "city": "Nagasaki", "country": "Japan", "latitude": 32.9169, "longitude": 129.9133},
  {"iata": "OIT", "icao": "RJFO", "name": "Oita Airport", "city": "Oita", "country": "Japan", "latitude": 33.4794, "longitude": 131.7367},
  {"iata": "KMI", "icao": "RJFM", "name": "Miyazaki Airport", "city": "Miyazaki", "country": "Japan", "latitude": 31.8772, "longitude": 131.4497},
  {"iata": "ASJ", "icao": "RJKA", "name": "Amami Airport", "city": "Amami", "country": "Japan", "latitude": 28.4306, "longitude": 129.7125},
  {"iata": "MMY", "icao": "ROMY", "name": "Miyako Airport", "city": "Miyakojima", "country": "Japan", "latitude": 24.7828, "longitude": 125.2940},
  {"iata": "UKB", "icao": "RJBE", "name": "Kobe Airport", "city": "Kobe", "country": "Japan", "latitude": 34.6328, "longitude": 135.2239},
  {"iata": "TTJ", "icao": "RJOR", "name": "Tottori Airport", "city": "Tottori", "country": "Japan", "latitude": 35.5306, "longitude": 134.1675},
  {"iata": "IZO", "icao": "RJOC", "name": "Izumo Airport", "city": "Izumo", "country": "Japan", "latitude": 35.4136, "longitude": 132.8892},
  {"iata": "OKJ", "icao": "RJOB", "name": "Okayama Airport", "city": "Okayama", "country": "Japan", "latitude": 34.7569, "longitude": 133.8542},
  {"iata": "KCZ", "icao": "RJOK", "name": "Kochi Airport", "city": "Kochi", "country": "Japan", "latitude": 33.5461, "longitude": 133.6694},
  {"iata": "MYJ", "icao": "RJOM", "name": "Matsuyama Airport", "city": "Matsuyama", "country": "Japan", "latitude": 33.8272, "longitude": 132.6997},
  {"iata": "HIW", "icao": "RJOH", "name": "Hiroshima-Nishi Airport", "city": "Hiroshima", "country": "Japan", "latitude": 34.3650, "longitude": 132.4147},
  {"iata": "AOJ", "icao": "RJSA", "name": "Aomori Airport", "city": "Aomori", "country": "Japan", "latitude": 40.7347, "longitude": 140.6900},
  {"iata": "GAJ", "icao": "RJSC", "name": "Yamagata Airport", "city": "Yamagata", "country": "Japan", "latitude": 38.4119, "longitude": 140.3714},
  {"iata": "HAC", "icao": "RJTH", "name": "Hachijojima Airport", "city": "Hachijojima", "country": "Japan", "latitude": 33.1150, "longitude": 139.7858},
  {"iata": "KUH", "icao": "RJCK", "name": "Kushiro Airport", "city": "Kushiro", "country": "Japan", "latitude": 43.0410, "longitude": 144.1930},
  {"iata": "MMB", "icao": "RJCM", "name": "Memanbetsu Airport", "city": "Memanbetsu", "country": "Japan", "latitude": 43.8806, "longitude": 144.1647},
  {"iata": "AXT", "icao": "RJSK", "name": "Akita Airport", "city": "Akita", "country": "Japan", "latitude": 39.6156, "longitude": 140.2189},
  {"iata": "OBO", "icao": "RJCB", "name": "Obihiro Airport", "city": "Obihiro", "country": "Japan", "latitude": 42.7333, "longitude": 143.2170},
  {"iata": "FSZ", "icao": "RJNS", "name": "Shizuoka Airport", "city": "Shizuoka", "country": "Japan", "latitude": 34.7961, "longitude": 138.1894},
  {"iata": "IKI", "icao": "RJDB", "name": "Iki Airport", "city": "Iki", "country": "Japan", "latitude": 33.7490, "longitude": 129.7850},
  {"iata": "OKD", "icao": "RJCO", "name": "Okadama Airport", "city": "Sapporo", "country": "Japan", "latitude": 43.1161, "longitude": 141.3803},
  {"iata": "SHM", "icao": "RJBD", "name": "Nanki-Shirahama Airport", "city": "Shirahama", "country": "Japan", "latitude": 33.6622, "longitude": 135.3630},
  {"iata": "YGJ", "icao": "RJOH", "name": "Yonago Kitaro Airport", "city": "Yonago", "country": "Japan", "latitude": 35.4922, "longitude": 133.2364},
  {"iata": "UBJ", "icao": "RJDC", "name": "Yamaguchi Ube Airport", "city": "Ube", "country": "Japan", "latitude": 33.9300, "longitude": 131.2790},
  {"iata": "KKJ", "icao": "RJFR", "name": "Kitakyushu Airport", "city": "Kitakyushu", "country": "Japan", "latitude": 33.8459, "longitude": 131.0350},
  {"iata": "TSJ", "icao": "RJDT", "name": "Tsushima Airport", "city": "Tsushima", "country": "Japan", "latitude": 34.2849, "longitude": 129.3300},
  {"iata": "ONJ", "icao": "RJSR", "name": "Odate Noshiro Airport", "city": "Odate", "country": "Japan", "latitude": 40.1919, "longitude": 140.3715},
  {"iata": "RIS", "icao": "RJER", "name": "Rishiri Airport", "city": "Rishiri", "country": "Japan", "latitude": 45.2420, "longitude": 141.1860},
  {"iata": "IWJ", "icao": "RJOW", "name": "Iwami Airport", "city": "Masuda", "country": "Japan", "latitude": 34.6764, "longitude": 131.7890},
  {"iata": "NTQ", "icao": "RJNW", "name": "Noto Airport", "city": "Wajima", "country": "Japan", "latitude": 37.2931, "longitude": 136.9622},
  {"iata": "KUM", "icao": "RJKA", "name": "Yakushima Airport", "city": "Yakushima", "country": "Japan", "latitude": 30.3856, "longitude": 130.6590},
  {"iata": "FKS", "icao": "RJSF", "name": "Fukushima Airport", "city": "Sukagawa", "country": "Japan", "latitude": 37.2274, "longitude": 140.4304},
  {"iata": "TKS", "icao": "RJOS", "name": "Tokushima Awaodori Airport", "city": "Tokushima", "country": "Japan", "latitude": 34.1328, "longitude": 134.6060},
  {"iata": "OKI", "icao": "RJNO", "name": "Oki Airport", "city": "Okinoshima", "country": "Japan", "latitude": 36.1811, "longitude": 133.3259},
  {"iata": "MMD", "icao": "ROMD", "name": "Minami-Daito Airport", "city": "Minami-Daito", "country": "Japan", "latitude": 25.8465, "longitude": 131.2637},
  {"iata": "SHI", "icao": "RORS", "name": "Shimojishima Airport", "city": "Miyakojima", "country": "Japan", "latitude": 24.8267, "longitude": 125.1440},
  {"iata": "TRA", "icao": "RORT", "name": "Taramajima Airport", "city": "Tarama", "country": "Japan", "latitude": 24.6539, "longitude": 124.6750},
  {"iata": "OIM", "icao": "RJTO", "name": "Oshima Airport", "city": "Izu Oshima", "country": "Japan", "latitude": 34.7820, "longitude": 139.3600},
  {"iata": "HND", "icao": "RJTT", "name": "Haneda Airport", "city": "Tokyo", "country": "Japan", "latitude": 35.5494, "longitude": 139.7798},
  {"iata": "NRT", "icao": "RJAA", "name": "Narita International Airport", "city": "Narita", "country": "Japan", "latitude": 35.7647, "longitude": 140.3860},
  {"iata": "LAX", "icao": "KLAX", "name": "Los Angeles International Airport", "city": "Los Angeles", "country": "USA", "latitude": 33.9416, "longitude": -118.4085},
  {"iata": "JFK", "icao": "KJFK", "name": "John F. Kennedy International Airport", "city": "New York", "country": "USA", "latitude": 40.6413, "longitude": -73.7781},
  {"iata": "SFO", "icao": "KSFO", "name": "San Francisco International Airport", "city": "San Francisco", "country": "USA", "latitude": 37.7749, "longitude": -122.4194},
  {"iata": "ORD", "icao": "KORD", "name": "O'Hare International Airport", "city": "Chicago", "country": "USA", "latitude": 41.9742, "longitude": -87.9073},
  {"iata": "SEA", "icao": "KSEA", "name": "Seattle-Tacoma International Airport", "city": "Seattle", "country": "USA", "latitude": 47.4502, "longitude": -122.3088},
  {"iata": "HNL", "icao": "PHNL", "name": "Daniel K. Inouye International Airport", "city": "Honolulu", "country": "USA", "latitude": 21.3187, "longitude": -157.9225},
  {"iata": "SYD", "icao": "YSSY", "name": "Sydney Kingsford Smith Airport", "city": "Sydney", "country": "Australia", "latitude": -33.9399, "longitude": 151.1753},
  {"iata": "MEL", "icao": "YMML", "name": "Melbourne Airport", "city": "Melbourne", "country": "Australia", "latitude": -37.6690, "longitude": 144.8410},
  {"iata": "BNE", "icao": "YBBN", "name": "Brisbane Airport", "city": "Brisbane", "country": "Australia", "latitude": -27.3842, "longitude": 153.1175},
  {"iata": "AKL", "icao": "NZAA", "name": "Auckland Airport", "city": "Auckland", "country": "New Zealand", "latitude": -37.0082, "longitude": 174.7850},
  {"iata": "LHR", "icao": "EGLL", "name": "Heathrow Airport", "city": "London", "country": "United Kingdom", "latitude": 51.4700, "longitude": -0.4543},
  {"iata": "CDG", "icao": "LFPG", "name": "Charles de Gaulle Airport", "city": "Paris", "country": "France", "latitude": 49.0097, "longitude": 2.5479},
  {"iata": "FRA", "icao": "EDDF", "name": "Frankfurt Airport", "city": "Frankfurt", "country": "Germany", "latitude": 50.0379, "longitude": 8.5622},
  {"iata": "AMS", "icao": "EHAM", "name": "Amsterdam Airport Schiphol", "city": "Amsterdam", "country": "Netherlands", "latitude": 52.3105, "longitude": 4.7683},
  {"iata": "SIN", "icao": "WSSS", "name": "Singapore Changi Airport", "city": "Singapore", "country": "Singapore", "latitude": 1.3644, "longitude": 103.9915},
  {"iata": "HKG", "icao": "VHHH", "name": "Hong Kong International Airport", "city": "Hong Kong", "country": "Hong Kong", "latitude": 22.3080, "longitude": 113.9185},
  {"iata": "ICN", "icao": "RKSI", "name": "Incheon International Airport", "city": "Seoul", "country": "South Korea", "latitude": 37.4602, "longitude": 126.4407},
  {"iata": "PEK", "icao": "ZBAA", "name": "Beijing Capital International Airport", "city": "Beijing", "country": "China", "latitude": 40.0801, "longitude": 116.5846},
  {"iata": "PVG", "icao": "ZSPD", "name": "Shanghai Pudong International Airport", "city": "Shanghai", "country": "China", "latitude": 31.1443, "longitude": 121.8083},
  {"iata": "CAN", "icao": "ZGGG", "name": "Guangzhou Baiyun International Airport", "city": "Guangzhou", "country": "China", "latitude": 23.3924, "longitude": 113.2988},
  {"iata": "BKK", "icao": "VTBS", "name": "Suvarnabhumi Airport", "city": "Bangkok", "country": "Thailand", "latitude": 13.6890, "longitude": 100.7501},
  {"iata": "KUL", "icao": "WMKK", "name": "Kuala Lumpur International Airport", "city": "Kuala Lumpur", "country": "Malaysia", "latitude": 2.7456, "longitude": 101.7099},
  {"iata": "MNL", "icao": "RPLL", "name": "Ninoy Aquino International Airport", "city": "Manila", "country": "Philippines", "latitude": 14.5086, "longitude": 121.0198},
  {"iata": "DEL", "icao": "VIDP", "name": "Indira Gandhi International Airport", "city": "Delhi", "country": "India", "latitude": 28.5562, "longitude": 77.1000},
  {"iata": "DOH", "icao": "OTBD", "name": "Hamad International Airport", "city": "Doha", "country": "Qatar", "latitude": 25.2731, "longitude": 51.6080},
  {"iata": "DXB", "icao": "OMDB", "name": "Dubai International Airport", "city": "Dubai", "country": "United Arab Emirates", "latitude": 25.2532, "longitude": 55.3657},
  {"iata": "IST", "icao": "LTFM", "name": "Istanbul Airport", "city": "Istanbul", "country": "Turkey", "latitude": 41.2753, "longitude": 28.7519},
  {"iata": "ZRH", "icao": "LSZH", "name": "Zurich Airport", "city": "Zurich", "country": "Switzerland", "latitude": 47.4647, "longitude": 8.5492},
  {"iata": "VIE", "icao": "LOWW", "name": "Vienna International Airport", "city": "Vienna", "country": "Austria", "latitude": 48.1103, "longitude": 16.5697},
  {"iata": "MUC", "icao": "EDDM", "name": "Munich Airport", "city": "Munich", "country": "Germany", "latitude": 48.3537, "longitude": 11.7750},
  {"iata": "YVR", "icao": "CYVR", "name": "Vancouver International Airport", "city": "Vancouver", "country": "Canada", "latitude": 49.1952, "longitude": -123.1761},
  {"iata": "YYZ", "icao": "CYYZ", "name": "Toronto Pearson International Airport", "city": "Toronto", "country": "Canada", "latitude": 43.6777, "longitude": -79.6248},
  {"iata": "SKD", "icao": "UTSS", "name": "Samarkand International Airport", "city": "Samarkand", "country": "Uzbekistan", "latitude": 39.69633, "longitude": 66.99087},
]
airports.each do |airport|
  Airport.create(
    iata: airport[:iata],
    icao: airport[:icao],
    name: airport[:name],
    city: airport[:city],
    country: airport[:country],
    latitude: airport[:latitude],
    longitude: airport[:longitude],
  )
end

puts "#{Airport.count} airports created"
puts "_" * 10

# Add Aircrafts

puts "creating aircrafts..."

airplanes = [
  {"model_short": "A223", "model_long": "Airbus A220"},
  {"model_short": "A21N", "model_long": "Airbus A321neo"},
  {"model_short": "A318", "model_long": "Airbus A318"},
  {"model_short": "A319", "model_long": "Airbus A319"},
  {"model_short": "A320", "model_long": "Airbus A320"},
  {"model_short": "A321", "model_long": "Airbus A321"},
  {"model_short": "A332", "model_long": "Airbus A330-200"},
  {"model_short": "A333", "model_long": "Airbus A330-300"},
  {"model_short": "A343", "model_long": "Airbus A340-300"},
  {"model_short": "A345", "model_long": "Airbus A340-500"},
  {"model_short": "A346", "model_long": "Airbus A340-600"},
  {"model_short": "A359", "model_long": "Airbus A350-900"},
  {"model_short": "A35K", "model_long": "Airbus A350-1000"},
  {"model_short": "A380", "model_long": "Airbus A380"},
  {"model_short": "B717", "model_long": "Boeing 717"},
  {"model_short": "B727", "model_long": "Boeing 727"},
  {"model_short": "B73G", "model_long": "Boeing 737-700"},
  {"model_short": "B738", "model_long": "Boeing 737-800"},
  {"model_short": "B739", "model_long": "Boeing 737-900"},
  {"model_short": "B744", "model_long": "Boeing 747-400"},
  {"model_short": "B748", "model_long": "Boeing 747-8"},
  {"model_short": "B752", "model_long": "Boeing 757-200"},
  {"model_short": "B753", "model_long": "Boeing 757-300"},
  {"model_short": "B763", "model_long": "Boeing 767-300"},
  {"model_short": "B764", "model_long": "Boeing 767-400"},
  {"model_short": "B772", "model_long": "Boeing 777-200"},
  {"model_short": "B773", "model_long": "Boeing 777-300"},
  {"model_short": "B77W", "model_long": "Boeing 777-300ER"},
  {"model_short": "B788", "model_long": "Boeing 787-8"},
  {"model_short": "B789", "model_long": "Boeing 787-9"},
  {"model_short": "B78J", "model_long": "Boeing 787-10"},
  {"model_short": "CR7", "model_long": "Bombardier CRJ-700"},
  {"model_short": "CR9", "model_long": "Bombardier CRJ-900"},
  {"model_short": "CRK", "model_long": "Bombardier CRJ-1000"},
  {"model_short": "E70", "model_long": "Embraer E170"},
  {"model_short": "E75", "model_long": "Embraer E175"},
  {"model_short": "E90", "model_long": "Embraer E190"},
  {"model_short": "E95", "model_long": "Embraer E195"},
  {"model_short": "DH8D", "model_long": "De Havilland Canada Dash 8-400"},
  {"model_short": "AT7", "model_long": "ATR 72"},
  {"model_short": "SU9", "model_long": "Sukhoi Superjet 100"},
  {"model_short": "A310", "model_long": "Airbus A310"},
  {"model_short": "AB3", "model_long": "Airbus A300"},
  {"model_short": "MD1", "model_long": "McDonnell Douglas MD-11"},
  {"model_short": "M80", "model_long": "McDonnell Douglas MD-80"},
  {"model_short": "M90", "model_long": "McDonnell Douglas MD-90"},
  {"model_short": "D10", "model_long": "McDonnell Douglas DC-10"},
  {"model_short": "D9S", "model_long": "McDonnell Douglas DC-9"},
  {"model_short": "F50", "model_long": "Fokker 50"},
  {"model_short": "F70", "model_long": "Fokker 70"},
  {"model_short": "F100", "model_long": "Fokker 100"},
  {"model_short": "AT42", "model_long": "ATR 42"},
  {"model_short": "E50P", "model_long": "Embraer Phenom 100"},
  {"model_short": "E55P", "model_long": "Embraer Phenom 300"},
  {"model_short": "C56X", "model_long": "Cessna Citation XLS"},
  {"model_short": "G280", "model_long": "Gulfstream G280"},
  {"model_short": "G650", "model_long": "Gulfstream G650"}
]

airplanes.each do |airplane|
  Aircraft.create(
    model_short: airplane[:model_short],
    model_long: airplane[:model_long],
  )
end

puts "#{Aircraft.count} aircrafts created"
puts "_" * 10

# Add Flights
# meguro_lat = 35.686963
# meguro_lon = 139.749462
# url = "https://opendata.adsb.fi/api/v2/lat/#{meguro_lat}/lon/#{meguro_lon}/dist/25"

puts "Creating a flight"

departure_airport = Airport.where(iata: "NRT").first
arrival_airport = Airport.where(iata: "ICN").first
airline = Airline.where(icao: "JJA").first
aircraft = Aircraft.where(model_short: "B738").first

Flight.create!(
  flight_number: "JJA1102",
  arrival_airport: arrival_airport,
  departure_airport: departure_airport,
  airline: airline,
  aircraft: aircraft,
  departure_datetime: "2025-02-25T11:35:00+00:00",
  arrival_datetime: "2025-02-25T14:30:00+00:00",
  latitude: 35.610990997073685,
  longitude: 139.76089848550072,
  altitude: 1965,
  heading: 149,
  horizontal_speed: 516
)

departure_airport = Airport.where(iata: "PEK").first
arrival_airport = Airport.where(iata: "HND").first
airline = Airline.where(icao: "ANA").first
aircraft = Aircraft.where(model_short: "B763").first

Flight.create!(
  flight_number: "ANA964",
  arrival_airport: arrival_airport,
  departure_airport: departure_airport,
  airline: airline,
  aircraft: aircraft,
  departure_datetime: "2025-02-25T08:25:00+00:00",
  arrival_datetime: "2025-02-25T12:40:00+00:00",
  latitude: 35.1318,
  longitude: 139.958,
  altitude: 2964,
  heading: 41,
  horizontal_speed: 489
)


# Add Games
