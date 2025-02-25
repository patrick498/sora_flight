class GamesController < ApplicationController

  def index

  end

  def load_game
    @game = Game.new
    authorize @game
  end

  def create
    get_nearby_flights = true
    if get_nearby_flights
      latitude = params[:latitude]
      longitude = params[:longitude]

      closest_flights = ClosestFlights.new(latitude: latitude, longitude: longitude)
      selected_flight = closest_flights.call

      # use find_or_create_by when getting airline, aircraft, aiport
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
      flight.save
      raise
    else
      flight = Flight.first
    end

    game = Game.new
    authorize game

    redirect_to game_play_path(flight: flight)

  end

  def play
    @flight = Flight.find(params[:flight])
    @game = Game.new
    @game.flight = @flight
    @game.user = current_user
    authorize @game
    # show in the AR a 3D model
    # use ar.js library
    # ??????????????????????????????????
    # get the location
    # call the api flight location
    # load the AR calculation to display the flight

    # render html.erb
  end
end
