class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only:[:play, :create] #remove once we have users

  def index
  @games = current_user.games
  end

  def show
    @game = Game.find(params[:id])
    authorize @game
    @results = results(@game)
  end

  def play
    @flight = Flight.new
    @game = Game.new(user: current_user)
    authorize @game

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
    @flights = Flight.all #CHANGE HERE TO FIND A FLIGHT NEAR BY?
    @airports = Airport.all
    @airline = Airline.all
    #@game.flight = @flight
    #@game.score = 0
    #@game.save
   # use find_or_create_by when getting airline, aircraft, aiport
  end

  def create
    @game = Game.new(game_params)
    @game.user = User.first #need the user login (current_user)
    @game.flight = Flight.first
    # @game.departure_airport_guess = Airport.first
    # @game.arrival_airport_guess = Airport.last
    # @game.airline_guess = Airline.last
    @game.aircraft_guess = Aircraft.last
    if @game.save
      redirect_to show_path(@game) #redirect to the results path which I think will be the show_path
    end
  end

  private

  def game_params
    params.require(:game).permit(:arrival_airport_guess_id, :departure_airport_guess_id, :airline_guess_id)
  end

end
