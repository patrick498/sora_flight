class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: "Airport"
  belongs_to :arrival_airport, class_name: "Airport"
  belongs_to :airline
  belongs_to :aircraft

  has_many :games, dependent: :destroy
  # has_many :users, through: :games

  validates :flight_number, :arrival_airport, :departure_airport, :airline, :aircraft, :departure_datetime, :arrival_datetime, :latitude, :longitude, :altitude, :heading, :horizontal_speed, presence: true
end
