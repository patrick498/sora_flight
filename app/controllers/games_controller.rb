class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:play, :show]

  def index

  end

  def show
    @game = Game.find(params[:id])
    authorize @game
    @results = results(@game)
  end

  def play
    @game = Game.new
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
  end

  def main
    @game = Game.new
    authorize @game
  end
end
