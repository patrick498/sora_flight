class Game < ApplicationRecord
  belongs_to :user
  belongs_to :flight
  belongs_to :departure_airport_guess, class_name: "Airport"
  belongs_to :arrival_airport_guess, class_name: "Airport"
  belongs_to :airline_guess, class_name: "Airline"
  belongs_to :aircraft_guess, class_name: "Aircraft"

  has_many :questions, dependent: :destroy

  has_one_attached :photo

  validates :user, :flight, :arrival_airport_guess, :score, presence: :true
end
