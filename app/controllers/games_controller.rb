class GamesController < ApplicationController

  def index

  end

  def play
    @game = Game.new
    authorize @game
  end
end
