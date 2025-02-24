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

# Add Games
