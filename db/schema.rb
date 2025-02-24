# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_02_24_105835) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aircrafts", force: :cascade do |t|
    t.string "model_short"
    t.string "model_long"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "airlines", force: :cascade do |t|
    t.string "iata"
    t.string "icao"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "airports", force: :cascade do |t|
    t.string "iata"
    t.string "icao"
    t.string "name"
    t.string "city"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flights", force: :cascade do |t|
    t.string "flight_number"
    t.datetime "departure_datetime"
    t.datetime "arrival_datetime"
    t.float "latitude"
    t.float "longitude"
    t.integer "altitude"
    t.integer "heading"
    t.integer "horizontal_speed"
    t.bigint "departure_airport_id", null: false
    t.bigint "arrival_airport_id", null: false
    t.bigint "airline_id", null: false
    t.bigint "aircraft_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aircraft_id"], name: "index_flights_on_aircraft_id"
    t.index ["airline_id"], name: "index_flights_on_airline_id"
    t.index ["arrival_airport_id"], name: "index_flights_on_arrival_airport_id"
    t.index ["departure_airport_id"], name: "index_flights_on_departure_airport_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "score"
    t.boolean "hint_altitude", default: false
    t.boolean "hint_heading", default: false
    t.boolean "hint_departure_time", default: false
    t.boolean "hint_arrival_time", default: false
    t.bigint "user_id", null: false
    t.bigint "flight_id", null: false
    t.bigint "departure_airport_guess_id", null: false
    t.bigint "arrival_airport_guess_id", null: false
    t.bigint "airline_guess_id", null: false
    t.bigint "aircraft_guess_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aircraft_guess_id"], name: "index_games_on_aircraft_guess_id"
    t.index ["airline_guess_id"], name: "index_games_on_airline_guess_id"
    t.index ["arrival_airport_guess_id"], name: "index_games_on_arrival_airport_guess_id"
    t.index ["departure_airport_guess_id"], name: "index_games_on_departure_airport_guess_id"
    t.index ["flight_id"], name: "index_games_on_flight_id"
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "flights", "aircrafts"
  add_foreign_key "flights", "airlines"
  add_foreign_key "flights", "airports", column: "arrival_airport_id"
  add_foreign_key "flights", "airports", column: "departure_airport_id"
  add_foreign_key "games", "aircrafts", column: "aircraft_guess_id"
  add_foreign_key "games", "airlines", column: "airline_guess_id"
  add_foreign_key "games", "airports", column: "arrival_airport_guess_id"
  add_foreign_key "games", "airports", column: "departure_airport_guess_id"
  add_foreign_key "games", "flights"
  add_foreign_key "games", "users"
end
