class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def index
  end

  def home

  end

  # to test map
  def map_test
    @flight = Flight.first
    @markers = []
    departure = {
      lat: @flight.departure_airport.latitude,
      lng: @flight.departure_airport.longitude,
      marker_html: view_context.image_tag(view_context.image_path("departure_icon.svg"), height: 100, width: 100, alt: "departure_icon")
    }
    destination = {
      lat: @flight.arrival_airport.latitude,
      lng: @flight.arrival_airport.longitude,
      marker_html: view_context.image_tag(view_context.image_path("arrival_icon.svg"), height: 100, width: 100, alt: "arrival_icon")
    }
    current_position = {
      lat: @flight.latitude,
      lng: @flight.longitude,
      marker_html: view_context.image_tag(view_context.image_path("airplane_icon.svg"), height: 100, width: 100, alt: "airplane_icon")
    }
    @markers = [ departure, destination, current_position ]
  end
end
