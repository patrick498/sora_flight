require 'open-uri'
require 'json'
require 'net/http'
class ClosestFlights

  # default place is Meguro
  def initialize(latitude: 35.686963, longitude: 139.749462)
    @latitude = latitude
    @longitude = longitude
  end

  def call
    distance = 25
    nearby_flights = nil
    while nearby_flights.nil? && distance <= 250
      nearby_flights = get_nearby_flights(distance)
      puts "#### NEARBT FLIGHTS"
      puts nearby_flights
      sorted_flights = nearby_flights
                              .select { |flight| flight["flight"] }
                              .map { |flight| flight.slice("flight", "dst")  }
                              .sort_by{ |flight| flight["dst"] }
      distance += 15
    end
    # nearby flight will definetely have something
    # but maybe it is does not have a live flight
    active_flight = []
    index = 0
    while active_flight.empty? && index < sorted_flights.length
      selected_flight = sorted_flights[index]
      #TODO: check if game already played
      flights = get_flight_details(selected_flight["flight"].strip!)
      puts "#### GET FLIGHT DETAIL"
      puts flights
      active_flight = flights.select { |flight| (flight["live"]) }
      puts "#### ACTIVE FLIGHT"
      p active_flight
      index += 1
    end
    if active_flight.any?
      # get dimensions
      flight = instantiate_flight(active_flight.first)
      return flight if flight.save
    else
      # random a flight
      return Flight.first
    end
  end

  private

  def instantiate_flight(selected_flight)

    unless Airport.exists?(iata: selected_flight["departure"]["iata"])
      save_new_airport(selected_flight["departure"]["iata"])
    end
    unless Airport.exists?(iata: selected_flight["arrival"]["iata"])
      save_new_airport(selected_flight["arrival"]["iata"])
    end
    unless Airline.exists?(iata: selected_flight["airline"]["iata"])
      save_new_airport(selected_flight["airline"]["iata"], selected_flight["airline"]["icao"])
    end

    departure_airport = Airport.where(iata: selected_flight["departure"]["iata"]).first
    arrival_airport = Airport.where(iata: selected_flight["arrival"]["iata"]).first
    airline = Airline.where(iata: selected_flight["airline"]["iata"]).first
    aircraft = Aircraft.where(model_short: selected_flight["aircraft"]["iata"]).first

    flight = Flight.new(
      flight_number: selected_flight["flight"]["iata"],
      departure_airport: departure_airport,
      arrival_airport: arrival_airport,
      airline: airline,
      aircraft: aircraft,
      departure_datetime: selected_flight["departure"]["scheduled"],
      arrival_datetime: selected_flight["arrival"]["scheduled"],
      latitude: selected_flight["live"]["latitude"],
      longitude: selected_flight["live"]["longitude"],
      altitude: selected_flight["live"]["longitude"].to_i,
      heading: selected_flight["live"]["direction"].to_i,
      horizontal_speed: selected_flight["live"]["speed_horizontal"].to_i
    )
  end

  def save_new_airport(airport_iata)
    url = "https://airport-info.p.rapidapi.com/airport?iata=#{airport_iata}"
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = 'a4caf3b860msh3556b4a270314dap12ef96jsn40fff99f4f4a'
    request["x-rapidapi-host"] = 'airport-info.p.rapidapi.com'

    response = http.request(request)
    data = JSON.parse(response.read_body)

    airport = Airport.new(
      iata: airport_iata,
      icao: data["icao"],
      name: data["name"],
      city: data["city"],
      country: data["country"],
      latitude: data["latitude"],
      longitude: data["longitude"]
    )
    airport.save
  end

  def save_new_airline(airline_iata, airline_icao)
    url = "https://iata-code-decoder.p.rapidapi.com/airlines?query=#{airline_iata}"
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = 'a4caf3b860msh3556b4a270314dap12ef96jsn40fff99f4f4a'
    request["x-rapidapi-host"] = 'iata-code-decoder.p.rapidapi.com'

    response = http.request(request)
    data = JSON.parse(response.read_body)["data"][0]

    airline = Airline.new(
      iata: airline_iata,
      icao: airline_icao,
      name: data["name"]
    )
    airline.save
  end

  def get_nearby_flights(distance)
    url = "https://opendata.adsb.fi/api/v2/lat/#{@latitude}/lon/#{@longitude}/dist/#{distance}"
    uri = URI(url)
    response = URI.open(uri).read
    data = JSON.parse(response)["aircraft"]
  end

  def get_flight_details(flight)
    url = "https://api.aviationstack.com/v1/flights"
    puts "########### FLIGHT !!!!#########"
    puts flight
    params = {
      access_key: ENV["AVIATION_ACCESS_KEY"],
      flight_icao: flight
    }
    uri = URI(url)
    uri.query = URI.encode_www_form(params)
    response = URI.open(uri).read
    data = JSON.parse(response)["data"]
  end
end
