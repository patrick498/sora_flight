class ChangeDefaultForHintsInGames < ActiveRecord::Migration[7.1]
  def change
    change_column_default :games, :hint_altitude, false
    change_column_default :games, :hint_heading, false
    change_column_default :games, :hint_departure_time, false
    change_column_default :games, :hint_arrival_time, false
  end
end
