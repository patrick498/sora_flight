class DashboardController < ApplicationController

  def index
  end

  def main
    @games = Game.new
    authorize @games
  end
end
