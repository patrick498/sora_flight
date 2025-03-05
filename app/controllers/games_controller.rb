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
    get_nearby_flights = true
    puts "########GET NEARBY FLIGHTS:"
    p get_nearby_flights
    if get_nearby_flights
      latitude = params[:latitude]
      longitude = params[:longitude]

      closest_flights = ClosestFlights.new(latitude: latitude, longitude: longitude)
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
    redirect_to game_play_path(flight: final_flight, latitude: params[:latitude], longitude: params[:longitude])

  end

  def play
    @game = Game.new
    @flight = Flight.find(params[:flight])
    max_radius = 5
    get_position = NewFlightPosition.new(params[:latitude], params[:longitude], @flight.latitude, @flight.longitude, max_radius)
    new_position = get_position.call
    @flight.latitude = new_position[:lat]
    @flight.longitude = new_position[:lon]
    @game.flight = @flight
    @game.user = current_user

    authorize @game

    #Wrong random options
    @departure_airports = Airport.where.not(id: @flight.departure_airport).sample(3)
    @arrival_airports = Airport.where.not(id: @flight.arrival_airport).sample(3)
    @airlines = Airline.where.not(id: @flight.airline).sample(3)

    #Correct answer
    @departure_airports << @flight.departure_airport
    @arrival_airports << @flight.arrival_airport
    @airlines << @flight.airline

    #Shuffle the options
    @departure_airports.shuffle!
    @arrival_airports.shuffle!
    @airlines.shuffle!

    @firstAnswer = @flight.departure_airport.id
    @secondAnswer = @flight.arrival_airport.id
    @thirdAnswer = @flight.airline.id
  end

  def create
    @game = Game.new(game_params)

    @game.user = current_user
    @flight = Flight.find(game_params[:flight_id])
    @game.flight = @flight
    # @game.departure_airport_guess_id = @flight.departure_airport_id
    # @game.arrival_airport_guess = Airport.last
    # @game.airline_guess_id = @flight.airline_id
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

    # Get all answered question IDs by the user
    answered_questions_ids = @game.user.guesses.joins(:choice).pluck('choices.question_id')

    # Find the next unanswered question
    @question = @game.questions.where.not(id: answered_questions_ids).first

    if @question.nil?
      redirect_to game_path(@game)
    end

    @guess = Guess.new(user: current_user)
    @markers = markers(@game.flight, location)
  end

  private

  def game_params
    params.require(:game).permit(:departure_airport_guess_id, :arrival_airport_guess_id, :airline_guess_id,  :flight_id)
  end

  def create_questions(game)
    question = Question.new()
    question.game = game
    question.content = "What does 'Mayday' signify in aviation?"
    if question.save
      puts "Question saved successfully!"
      create_choice(question, 'Emergency distress call', true)
      create_choice(question, 'Request to land', false)
      create_choice(question, 'Weather alert', false)
      create_choice(question, 'Low fuel warning', false)
    else
      puts "Error saving question:"
      puts question.errors.full_messages.join(", ")
    end
  end

  def create_choice(question, content, correct)
    choice = Choice.create()
    choice.question = question
    choice.content = content
    choice.correct = correct
    choice.save
  end

  def results(game)
    results_array = []
    if game.departure_airport_guess_id.present?
      guess = Airport.find(game.departure_airport_guess_id).name
      answer = Airport.find(game.flight.departure_airport_id).name
      correct = game.departure_airport_guess_id == game.flight.departure_airport_id
      results_array << { question: 'Departure', guess: guess, answer: answer, correct: correct }
    end
    if game.arrival_airport_guess_id.present?
      guess = Airport.find(game.arrival_airport_guess_id).name
      answer = Airport.find(game.flight.arrival_airport_id).name
      correct = game.arrival_airport_guess_id == game.flight.arrival_airport_id
      results_array << { question: 'Arrival', guess: guess, answer: answer, correct: correct }
    end
    if game.airline_guess_id.present?
      guess = Airline.find(game.airline_guess_id).name
      answer = Airline.find(game.flight.airline_id).name
      correct = game.airline_guess_id == game.flight.airline_id
      results_array << { question: 'Airline', guess: guess, answer: answer, correct: correct }
    end
    return results_array
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
