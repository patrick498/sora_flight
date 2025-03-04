game = Game.new()
game.user = User.find(19)
game.flight = Flight.first
game.score = 0
game.departure_airport_guess = game.flight.departure_airport
game.arrival_airport_guess = Airport.first
game.airline_guess = game.flight.airline
game.aircraft_guess = Aircraft.first



belongs_to :user
belongs_to :flight
belongs_to :departure_airport_guess, class_name: "Airport"
belongs_to :arrival_airport_guess, class_name: "Airport"
belongs_to :airline_guess, class_name: "Airline"
belongs_to :aircraft_guess, class_name: "Aircraft"
"user_id", null: false
    t.bigint "flight_id", null: false
    t.bigint "departure_airport_guess_id", null: false
    t.bigint "arrival_airport_guess_id", null: false
    t.bigint "airline_guess_id", null: false
    t.bigint "aircraft_guess_id", null: false

#Questions seed for game with id 154 (change the ID to that of an existing game)
game = Game.find(154)

questions_data = [
  {
    content: "What is the primary purpose of an aircraft's flaps?",
    choices: [
      { content: "Increase lift and drag during takeoff and landing", correct: true },
      { content: "Reduce fuel consumption", correct: false },
      { content: "Improve passenger comfort", correct: false },
      { content: "Enhance engine efficiency", correct: false }
    ]
  },
  {
    content: "Which of the following is not a type of aircraft?",
    choices: [
      { content: "Boeing 747", correct: false },
      { content: "Cessna 172", correct: false },
      { content: "Airbus A380", correct: false },
      { content: "Honda Civic", correct: true }
    ]
  },
  {
    content: "What does ATC stand for in aviation?",
    choices: [
      { content: "Air Traffic Control", correct: true },
      { content: "Aero Transport Command", correct: false },
      { content: "Aircraft Technical Certification", correct: false },
      { content: "Automated Takeoff Computer", correct: false }
    ]
  }
]

questions_data.each do |q_data|
  question = game.questions.create!(content: q_data[:content])

  q_data[:choices].each do |c_data|
    question.choices.create!(content: c_data[:content], correct: c_data[:correct])
  end
end

puts "Seeded 3 aviation questions for Game 154!"
