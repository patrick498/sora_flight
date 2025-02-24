class GamesController < ApplicationController

  def index

  end

  def play
    @game = Game.new
    authorize @game

    # use find_or_create_by when getting airline, aircraft, aiport
  end
end
