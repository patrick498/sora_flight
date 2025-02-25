require 'open-uri'

puts "Cleaning the db...\n"
puts "Destroying Users\n"
User.destroy_all
puts "Users: #{User.count}"

puts "Destroying Airline\n"
Airline.destroy_all
puts "Airline: #{Airline.count}"

puts "Destroying Airports\n"
Airport.destroy_all
puts "Airports: #{Airport.count}"

puts "Destroying Aircrafts\n"
Aircraft.destroy_all
puts "Aircrafts: #{Aircraft.count}"

puts "Destroying Flights\n"
Flight.destroy_all
puts "Flights: #{Flight.count}"
puts "############"



# Add User

# Add Airline

# Add Airports

# Add Aircrafts

# Add Flights
# meguro_lat = 35.686963
# meguro_lon = 139.749462
# url = "https://opendata.adsb.fi/api/v2/lat/#{meguro_lat}/lon/#{meguro_lon}/dist/25"

puts "Creating a flight"

departure_airport = Aiport.where(iata: "NRT")
arrival_airport = Airport.where(iata: "ICN")
airline = Airline.where(icao: "JJA")
aircraft = Aircraft.where(model_short: "B738")

Flight.create!(
  flight_number: "JJA1102",
  arrival_airport: arrival_airport,
  departure_airport: departure_airport,
  airline: airline,
  aircraft: aircraft,
  departure_date: "2025-02-25T11:35:00+00:00",
  arrival_date: "2025-02-25T14:30:00+00:00",
  latitude: 35.5762,
  longitude: 140.511,
  altitude: 1965,
  heading: 149,
  speed: 516
)

departure_airport = Aiport.where(iata: "PEK")
arrival_airport = Airport.where(iata: "HND")
airline = Airline.where(icao: "ANA")
aircraft = Aircraft.where(model_short: "B763")

Flight.create!(
  flight_number: "ANA964",
  arrival_airport: arrival_airport,
  departure_airport: departure_airport,
  airline: airline,
  aircraft: aircraft,
  departure_date: "2025-02-25T08:25:00+00:00",
  arrival_date: "2025-02-25T12:40:00+00:00",
  latitude: 35.1318,
  longitude: 139.958,
  altitude: 2964,
  heading: 41,
  speed: 489
)


# Add Games
