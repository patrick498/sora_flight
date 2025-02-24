class CreateAircrafts < ActiveRecord::Migration[7.1]
  def change
    create_table :aircrafts do |t|
      t.string :model_short
      t.string :model_long

      t.timestamps
    end
  end
end
