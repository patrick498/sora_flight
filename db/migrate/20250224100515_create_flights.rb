class CreateFlights < ActiveRecord::Migration[7.1]
  def change
    create_table :flights do |t|
      t.string :flight_number
      t.datetime :departure_datetime
      t.datetime :arrival_datetime
      t.float :latitude
      t.float :longitude
      t.integer :altitude
      t.integer :heading
      t.integer :horizontal_speed
      t.references :departure_airport, null: false, foreign_key: { to_table: :airports }
      t.references :arrival_airport, null: false, foreign_key: { to_table: :airports }
      t.references :airline, null: false, foreign_key: true
      t.references :aircraft, null: false, foreign_key: true

      t.timestamps
    end
  end
end
