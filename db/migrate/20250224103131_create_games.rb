class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.integer :score
      t.boolean :hint_altitude
      t.boolean :hint_heading
      t.boolean :hint_departure_time
      t.boolean :hint_arrival_time
      t.references :user, null: false, foreign_key: true
      t.references :flight, null: false, foreign_key: true
      t.references :departure_airport_guess, null: false, foreign_key: { to_table: :airports }
      t.references :arrival_airport_guess, null: false, foreign_key: { to_table: :airports }
      t.references :airline_guess, null: false, foreign_key: { to_table: :airlines }
      t.references :aircraft_guess, null: false, foreign_key: { to_table: :aircrafts }

      t.timestamps
    end
  end
end
