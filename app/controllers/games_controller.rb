class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only:[:play, :setup, :show] #remove once we have users

  def index
    @games = current_user.games
  end

  def show
    # Retrieve stored badges before the game (from session)
    badges_before = session[:badges_before]
    badges_all = current_user.badges.map(&:id) || []
    @new_badge_ids = badges_all - badges_before
    @new_badges = @new_badge_ids.map { |id| Merit::Badge.find(id) }

    # FOR TESTING DISPLAYING BADGES ONLY
    # @new_badges = [ Merit::Badge.find(1) ]

    @game = Game.find(params[:id])
    authorize @game
    @results = results(@game)
    @game.user.add_points(@game.score)
  end

  def load_game
    if params[:flight_count].nil?
      @flight_count = 1
    else
      @flight_count = params[:flight_count]
    end
    @game = Game.new
    authorize @game
  end

  def setup
    get_nearby_flights = false
    puts "########GET NEARBY FLIGHTS:"
    p get_nearby_flights
    if get_nearby_flights
      latitude = params[:latitude]
      longitude = params[:longitude]

      closest_flights = ClosestFlights.new(latitude: latitude, longitude: longitude)
      selected_flight = closest_flights.call
      puts "######SELECTED FLIGHT"
      p selected_flight
      flights = selected_flight
    else
      # get flights from db
      flights = Flight.first(3)
    end

    game = Game.new
    authorize game
    puts "##############FINAL FLIGHT"
    p flights
    redirect_to game_play_path(flights: flights, latitude: params[:latitude], longitude: params[:longitude], flight_count: params[:flight_count])

  end

  def play
    @game = Game.new
    @flights = []
    max_radius = 6

    all_airports = Airport.all
    all_airlines = Airline.all

    params[:flights].each do |flight_id|
      flight = Flight.find(flight_id)
      # Get new positions
      get_new_plane_position = NewElementPosition.new(params[:latitude], params[:longitude], flight.latitude, flight.longitude, max_radius)
      new_plane_position = get_new_plane_position.call
      get_new_departure_position = NewElementPosition.new(params[:latitude], params[:longitude], flight.departure_airport.latitude, flight.departure_airport.longitude, 7)
      new_departure_position = get_new_departure_position.call
      get_new_arrival_position = NewElementPosition.new(params[:latitude], params[:longitude], flight.arrival_airport.latitude, flight.arrival_airport.longitude, 7)
      new_arrival_position = get_new_arrival_position.call
      get_arrow_departure_position = NewElementPosition.new(params[:latitude], params[:longitude], flight.departure_airport.latitude, flight.departure_airport.longitude, 0.13)
      arrow_departure_position = get_arrow_departure_position.call
      get_arrow_arrival_position = NewElementPosition.new(params[:latitude], params[:longitude], flight.arrival_airport.latitude, flight.arrival_airport.longitude, 0.13)
      arrow_arrival_position = get_arrow_arrival_position.call
      get_text_departure_position = NewElementPosition.new(params[:latitude], params[:longitude], flight.departure_airport.latitude, flight.departure_airport.longitude, 0.08)
      text_departure_position = get_text_departure_position.call
      get_text_arrival_position = NewElementPosition.new(params[:latitude], params[:longitude], flight.arrival_airport.latitude, flight.arrival_airport.longitude, 0.08)
      text_arrival_position = get_text_arrival_position.call
      get_distance_departure = DistanceTwoPoints.new(params[:latitude], params[:longitude], flight.departure_airport.latitude, flight.departure_airport.longitude)
      get_distance_arrival = DistanceTwoPoints.new(params[:latitude], params[:longitude], flight.arrival_airport.latitude, flight.arrival_airport.longitude)

      # Alternatives
      # Wrong random options
      departure_airports = all_airports.where.not(id: flight.departure_airport.id).sample(3)
      arrival_airports = all_airports.where.not(id: flight.arrival_airport.id).sample(3)
      airlines = all_airlines.where.not(id: flight.airline.id).sample(3)

      # Correct answer
      departure_airports << flight.departure_airport
      arrival_airports << flight.arrival_airport
      airlines << flight.airline

      departure_airports.shuffle!.map! { |x| x.attributes  }
      arrival_airports.shuffle!.map! { |x| x.attributes  }
      airlines.shuffle!.map! { |x| x.attributes  }

      first_answer = flight.departure_airport.id
      second_answer = flight.arrival_airport.id
      third_answer = flight.airline.id

      new_flight = {
        flight: flight.attributes,
        new_plane_latitude: new_plane_position[:lat],
        new_plane_longitude: new_plane_position[:lon],
        # Get new position for airports
        new_departure_latitude: new_departure_position[:lat],
        new_departure_longitude: new_departure_position[:lon],
        departure_bearing: new_departure_position[:bearing],
        new_arrival_latitude: new_arrival_position[:lat],
        new_arrival_longitude: new_arrival_position[:lon],
        arrival_bearing: new_arrival_position[:bearing],
        # Get new positions for arrows
        arrow_departure_latitude: arrow_departure_position[:lat],
        arrow_departure_longitude: arrow_departure_position[:lon],
        arrow_arrival_latitude: arrow_arrival_position[:lat],
        arrow_arrival_longitude: arrow_arrival_position[:lon],
        # Get new positions for texts
        text_departure_latitude: text_departure_position[:lat],
        text_departure_longitude: text_departure_position[:lon],
        text_arrival_latitude: text_arrival_position[:lat],
        text_arrival_longitude: text_arrival_position[:lon],
        # Get distances
        distance_departure: get_distance_departure.call.to_i,
        distance_arrival: get_distance_arrival.call.to_i,
        # Choices
        departure_airports: departure_airports,
        arrival_airports: arrival_airports,
        airlines: airlines,
        first_answer: first_answer,
        second_answer: second_answer,
        third_answer: third_answer
      }
      @flights << new_flight
    end

    @game.user = current_user
    authorize @game

    @flight_count = params[:flight_count]
  end

  def create
    # store existing badges before the game starts
    session[:badges_before] = current_user.badges.map(&:id)

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

  # unused method for now
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
    results = {}
    questions_results = []
    if game.departure_airport_guess_id.present?
      guess = Airport.find(game.departure_airport_guess_id).iata
      answer = Airport.find(game.flight.departure_airport_id).iata
      correct = game.departure_airport_guess_id == game.flight.departure_airport_id
      questions_results << { question: 'departure', guess: guess, answer: answer, correct: correct }
    end
    if game.arrival_airport_guess_id.present?
      guess = Airport.find(game.arrival_airport_guess_id).iata
      answer = Airport.find(game.flight.arrival_airport_id).iata
      correct = game.arrival_airport_guess_id == game.flight.arrival_airport_id
      questions_results << { question: 'arrival', guess: guess, answer: answer, correct: correct }
    end
    if game.airline_guess_id.present?
      guess = Airline.find(game.airline_guess_id).name
      answer = Airline.find(game.flight.airline_id).name
      correct = game.airline_guess_id == game.flight.airline_id
      questions_results << { question: 'airline', guess: guess, answer: answer, correct: correct }
    end
    correct_answers = 0
    questions_results.each do |question_result|
      if question_result[:correct]
        correct_answers += 1
      end
    end
    game.score += correct_answers * 10
    cabin_class = cabin_class(game.score)
    results = { correct_answers: correct_answers, total_questions: questions_results.size, questions_results: questions_results, cabin_class: cabin_class }
    return results
  end

  def cabin_class(score)
    if score < 10
    cabin_class = 'CARGO'
    elsif score >= 10 && score < 20
      cabin_class = 'ECONOMY'
    elsif score >= 20 && score < 30
      cabin_class = 'BUSINESS'
    elsif score >= 30
      cabin_class = 'FIRST'
    end
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

  # def count_score(game, results_array)
  # end

end
