class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only:[:play, :setup, :show] #remove once we have users

  def index
    @games = current_user.games
  end

  def show
    @game = Game.find(params[:id])
    authorize @game
    @results = results(@game)
    count_score(@game, @results)
    @game.user.add_points(@game.score)
  end

  def load_game
    @game = Game.new
    authorize @game
  end

  def setup
    get_nearby_flights = false
    if get_nearby_flights
      latitude = params[:latitude]
      longitude = params[:longitude]

      # closest_flights = ClosestFlights.new(latitude: latitude, longitude: longitude)
      closest_flights = ClosestFlights.new(latitude, longitude)
      selected_flight = closest_flights.call

      # use find_or_create_by when getting airline, aircraft, aiport
      departure_airport = Airport.where(iata: selected_flight["departure"]["iata"])
      departure_airport = Airport.find_or_create_by(iata: selected_flight["departure"]["iata"]) do |airport|
        airport.name = 'John Doe'
        airport.age = 30
      end
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
      if flight.save
        redirect_to game_play_path(flight: flight, longitude: flight.longitude, latitude: flight.latitude)
      else
        redirect_to game_load_path
      end
    else
      flight = Flight.first
    end

    game = Game.new
    authorize game
    # TODO: check if it is saved OR find_insert
    redirect_to game_play_path(flight: flight, longitude: flight.longitude, latitude: flight.latitude)

  end

  def play
    # @latitude = params[:latitude]
    # @longitude = params[:longitude]
    @game = Game.new
    @flight = Flight.find(params[:flight])
    @game.flight = @flight
    @game.user = current_user

    authorize @game

    #Wrong random options
    @arrival_airports = Airport.where.not(id: @flight.arrival_airport).sample(3)

    #Correct answer
    @arrival_airports << @flight.arrival_airport

    #Shuffle the options
    @arrival_airports.shuffle!

    # @flights = Flight.all #CHANGE HERE TO FIND A FLIGHT NEAR BY?
    # @airports = Airport.all
    # @airline = Airline.all
    #@game.flight = @flight
    #@game.score = 0
    #@game.save
   # use find_or_create_by when getting airline, aircraft, aiport
  end

  def create
    @game = Game.new(game_params)
    @game.user = current_user
    @flight = Flight.first
    @game.flight = @flight
    @game.departure_airport_guess_id = @flight.departure_airport_id
    # @game.arrival_airport_guess = Airport.last
    @game.airline_guess_id = @flight.airline_id
    @game.aircraft_guess_id = @flight.aircraft_id
    @game.score = 0
    authorize @game
    if @game.save
      redirect_to game_path(@game)
    end
  end

  private

  def game_params
    params.require(:game).permit(:arrival_airport_guess_id)
  end

  def results(game)
    results_array = []
    if game.departure_airport_guess_id.present?
      results_array << { question: 'Departure', correct: game.departure_airport_guess_id == game.flight.departure_airport_id }
    end
    if game.arrival_airport_guess_id.present?
      results_array << { question: 'Arrival', correct: game.arrival_airport_guess_id == game.flight.arrival_airport_id }
    end
    if game.airline_guess_id.present?
      results_array << { question: 'Airline', correct: game.airline_guess_id == game.flight.airline_id }
    end
    if game.aircraft_guess_id.present?
      results_array << { question: 'Aircraft', correct: game.aircraft_guess_id == game.flight.aircraft_id }
    end
    return results_array
  end

  def count_score(game, results_array)
    results_array.each do |result|
      if result[:correct]
        game.score += 10
      end
    end
  end
end
