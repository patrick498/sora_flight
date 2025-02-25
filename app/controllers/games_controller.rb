class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only:[:play]

  def index
  @games = current_user.games
  end

  def play
    @game = Game.new(user: current_user)
    authorize @game
    @flight = Flight.create(arrival_airport: "Narita") #CHANGE HERE TO FIND A FLIGHT NEAR BY?
    #@game.flight = @flight
    #@game.score = 0
    #@game.save
   # use find_or_create_by when getting airline, aircraft, aiport
  end

  def create
    @game = Game.new
    @game.user = current_user
    if @game.save
      redirect_to show_path #redirect to the results path which I think will be the show_path
    end
  end
end
