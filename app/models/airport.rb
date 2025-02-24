class Airport < ApplicationRecord
  has_many :departing_flights, class_name: "Flight", foreign_key: "departure_airport_id"
  has_many :arriving_flights, class_name: "Flight", foreign_key: "arrival_airport_id"
  # has_many :departure_airport_guesses, class_name: "Games", foreign_key: "departure_airport_guess_id"
  # has_many :arrval_airport_guesses, class_name: "Games", foreign_key: "arrival_airport_guess_id"
end
