class Game < ApplicationRecord
  belongs_to :user
  belongs_to :flight
  belongs_to :departure_airport_guess, class_name: "Airport"
  belongs_to :arrival_airport_guess, class_name: "Airport"
  belongs_to :airline_guess, class_name: "Airline"
  belongs_to :aircraft_guess, class_name: "Aircraft"

  has_one_attached :photo

  validates :user, :flight, :departure_airport_guess, :arrival_airport_guess, :airline_guess, :aircraft_guess, :score, presence: :true
end
