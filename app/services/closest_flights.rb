require 'open-uri'
require 'json'
class ClosestFlights

  # default place is Meguro
  def initialize(latitude: 35.686963, longitude: 139.749462)
    @latitude = latitude
    @longitude = longitude
  end

  def call
    nearby_flights = get_nearby_flights()
    sorted_flights = nearby_flights.map { |flight| flight.slice("flight", "dst")  } .sort_by{ |flight| flight["dst"] }
    selected_flight = sorted_flights.first
    #TODO: check if game already played
    flights = get_flight_details(selected_flight["flight"].strip!)
    active_flight = flights.select { |flight| (flight["live"]) }
    active_flight.first
  end

  private

  def get_nearby_flights
    url = "https://opendata.adsb.fi/api/v2/lat/#{@latitude}/lon/#{@longitude}/dist/40"
    uri = URI(url)
    response = URI.open(uri).read
    data = JSON.parse(response)["aircraft"]
  end

  def get_flight_details(flight)
    url = "https://api.aviationstack.com/v1/flights"
    params = {
      access_key: "4e3dc4399d7d8f88546d1f0227b754a9",
      flight_icao: flight
    }
    uri = URI(url)
    uri.query = URI.encode_www_form(params)
    response = URI.open(uri).read
    data = JSON.parse(response)["data"]
  end
end
