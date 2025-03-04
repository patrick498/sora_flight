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

      closest_flights = ClosestFlights.new(latitude: latitude, longitude: longitude)
      # closest_flights = ClosestFlights.new()
      selected_flight = closest_flights.call
      puts "######SELECTED FLIGHT"
      p selected_flight
      final_flight = selected_flight
    else
      final_flight = Flight.first
    end

    game = Game.new
    authorize game
    puts "##############FINAL FLIGHT"
    p final_flight
    redirect_to game_play_path(flight: final_flight)

  end

  def play
    @game = Game.new
    @flight = Flight.find(params[:flight])
    # distance - 2 workarounds
    # 1 - get distance from closes_flight -> then make a function to calculate model
    #scale to be bigger
    # -easier but can make the model look strange
    # 2 - always change the display laittude and longitude to a nearby radius
    # -more maths
    @game.flight = @flight
    @game.user = current_user

    authorize @game

    #Wrong random options
    @arrival_airports = Airport.where.not(id: @flight.arrival_airport).sample(3)

    #Correct answer
    @arrival_airports << @flight.arrival_airport

    #Shuffle the options
    @arrival_airports.shuffle!

  end

  def create
    @game = Game.new(game_params)
    @game.user = current_user
    @flight = Flight.find(game_params[:flight_id])
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

  def quiz
    if params[:id]
      @game = Game.find(params[:id])
    else
      @game = Game.first
    end
    location = @game.flight
    @game.user = current_user
    authorize @game
    @markers = markers(@game.flight, location)
  end

  private

  def game_params
    params.require(:game).permit(:arrival_airport_guess_id, :flight_id)
  end

  def results(game)
    results_array = []
    if game.arrival_airport_guess_id.present?
      guess = Airport.find(game.arrival_airport_guess_id).name
      answer = Airport.find(game.flight.arrival_airport_id).name
      correct = game.arrival_airport_guess_id == game.flight.arrival_airport_id
      results_array << { question: 'Arrival', guess: guess, answer: answer, correct: correct }
    end
    # if game.departure_airport_guess_id.present?
    #   results_array << { question: 'Departure', correct: game.departure_airport_guess_id == game.flight.departure_airport_id }
    # end
    # if game.airline_guess_id.present?
    #   results_array << { question: 'Airline', correct: game.airline_guess_id == game.flight.airline_id }
    # end
    # if game.aircraft_guess_id.present?
    #   results_array << { question: 'Aircraft', correct: game.aircraft_guess_id == game.flight.aircraft_id }
    # end
    # return results_array
  end

  # returns markers for departure, arrival, and current position
  def markers(flight, location)
    departure = {
      lat: flight.departure_airport.latitude,
      lng: flight.departure_airport.longitude,
      marker_html: view_context.image_tag(view_context.image_path("location_icon.svg"), height: 50, width: 50, alt: "departure_icon")
    }
    destination = {
      lat: flight.arrival_airport.latitude,
      lng: flight.arrival_airport.longitude,
      marker_html: view_context.image_tag(view_context.image_path("location_icon.svg"), height: 50, width: 50, alt: "arrival_icon")
    }
    current_position = {
      lat: location.latitude,
      lng: location.longitude,
      marker_html: view_context.image_tag(view_context.image_path("airplane_icon.svg"), height: 100, width: 100, alt: "airplane_icon")
    }
    return [ departure, destination, current_position ]
  end

  def count_score(game, results_array)
    results_array.each do |result|
      if result[:correct]
        game.score += 10
      end
    end
  end
end
