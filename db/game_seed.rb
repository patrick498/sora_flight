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
