require 'open-uri'
require 'json'
class AviationInformations

  # default place is Meguro
  def initialize
  end

  def call(info)

  end

  private

  def get_nearby_flights
    url = "https://opendata.adsb.fi/api/v2/lat/#{@latitude}/lon/#{@longitude}/dist/25"
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
