class CreateAirlines < ActiveRecord::Migration[7.1]
  def change
    create_table :airlines do |t|
      t.string :iata
      t.string :icao
      t.string :name

      t.timestamps
    end
  end
end
