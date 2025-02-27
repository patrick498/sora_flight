class DashboardController < ApplicationController

  def index
  end

  def main
    @games = current_user.games
    authorize @games
  end
end
