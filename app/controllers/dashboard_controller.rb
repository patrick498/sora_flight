class DashboardController < ApplicationController

  def index
  end

  def main
    user = current_user
    @games = user.games
    authorize @games
    @flight_ids = @games.pluck(:flight_id).first(5)
    @total_games = user.games.count
    @badges = user.badges.count
    @correct_rate = correct_rate
    @total_planes = planes_number

    @all_badges = Merit::Badge.all
    @earned_badges = current_user.badges.map(&:id)
    return if @games.blank?

    @most_plane = Aircraft.find(most(:aircraft_guess_id)[0]).model_long
  end

  private

  def correct_rate
    games = current_user.games
    guesses = games.pluck(:arrival_airport_guess_id)
    return if guesses.blank?

    flights = games.pluck(:flight_id)
    airports = flights.map { |f| Flight.find(f).arrival_airport_id }.tally
    correct = guesses.tally.sum { |num, count1| [count1, airports[num] || 0].min }
    correct * 100 / guesses.count
  end

  def planes_number
    current_user.games.pluck(:aircraft_guess_id).tally.count
  end

  def most(data)
    current_user.games.pluck(data).tally.min_by { |_, v| -v }
  end
end
