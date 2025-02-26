class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only:[:play, :create, :show] #remove once we have users

  def index
  @games = current_user.games
  end

  def show
    @game = Game.find(params[:id])
    authorize @game
    @results = results(@game)
  end

  def load_game
    @game = Game.new
    authorize @game
  end

  def create
    get_nearby_flights = false
    if get_nearby_flights
      latitude = params[:latitude]
      longitude = params[:longitude]

      # closest_flights = ClosestFlights.new(latitude: latitude, longitude: longitude)
      closest_flights = ClosestFlights.new()
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
    else
      flight = Flight.first
    end

    game = Game.new
    authorize game
    # TODO: check if it is saved OR find_insert
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
    # @flights = Flight.all #CHANGE HERE TO FIND A FLIGHT NEAR BY?
    # @airports = Airport.all
    # @airline = Airline.all
    #@game.flight = @flight
    #@game.score = 0
    #@game.save
   # use find_or_create_by when getting airline, aircraft, aiport
  end


  def results(game)
    results_array = []
    arrival_airport_guess = Airport.find(game.arrival_airport_guess_id)
    arrival_airport_answer = Airport.find(game.flight.arrival_airport_id)
    results_array << single_result('arrival', arrival_airport_guess, arrival_airport_answer)
    return results_array
  end

  def single_result(question, guess, correct_answer)
    return { question: question, guess: guess, correct_answer: correct_answer}
  end

  # def create
  #   @game = Game.new(game_params)
  #   @game.user = User.first #need the user login (current_user)
  #   @game.flight = Flight.first
  #   # @game.departure_airport_guess = Airport.first
  #   # @game.arrival_airport_guess = Airport.last
  #   # @game.airline_guess = Airline.last
  #   @game.aircraft_guess = Aircraft.last
  #   if @game.save
  #     redirect_to show_path(@game) #redirect to the results path which I think will be the show_path
  #   end
  # end

  private

  def game_params
    params.require(:game).permit(:arrival_airport_guess_id, :departure_airport_guess_id, :airline_guess_id)
  end

end
