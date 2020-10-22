# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_13_135456) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "airports", primary_key: "code", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.bigint "city_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_airports_on_city_id"
    t.index ["name"], name: "index_airports_on_name"
  end

  create_table "bookings", primary_key: "number", id: :string, force: :cascade do |t|
    t.bigint "trip_id"
    t.bigint "package_id"
    t.decimal "transporter_proposed_price", precision: 10, scale: 2
    t.decimal "dispatcher_proposed_price", precision: 10, scale: 2
    t.decimal "price", precision: 10, scale: 2
    t.string "currency_code", null: false
    t.integer "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["currency_code"], name: "index_bookings_on_currency_code"
    t.index ["package_id"], name: "index_bookings_on_package_id"
    t.index ["trip_id"], name: "index_bookings_on_trip_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.string "country_code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_code"], name: "index_cities_on_country_code"
  end

  create_table "countries", primary_key: "code", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "currencies", primary_key: "code", id: :string, force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "package_items", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "count", default: 1, null: false
    t.bigint "package_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["package_id"], name: "index_package_items_on_package_id"
  end

  create_table "package_pricings", force: :cascade do |t|
    t.bigint "package_id"
    t.decimal "price", precision: 10, scale: 2, null: false
    t.string "currency_code", null: false
    t.boolean "negotiable"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["currency_code"], name: "index_package_pricings_on_currency_code"
    t.index ["package_id"], name: "index_package_pricings_on_package_id"
  end

  create_table "packages", force: :cascade do |t|
    t.text "description"
    t.string "origin_airport_code", null: false
    t.string "destination_airport_code", null: false
    t.decimal "weight", precision: 10, scale: 2
    t.integer "status", null: false
    t.text "preference"
    t.citext "dispatcher_email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["destination_airport_code"], name: "index_packages_on_destination_airport_code"
    t.index ["dispatcher_email"], name: "index_packages_on_dispatcher_email"
    t.index ["origin_airport_code"], name: "index_packages_on_origin_airport_code"
  end

  create_table "trip_pricings", force: :cascade do |t|
    t.bigint "trip_id"
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.decimal "minimum_price", precision: 10, scale: 2, null: false
    t.string "currency_code", null: false
    t.boolean "negotiable"
    t.index ["currency_code"], name: "index_trip_pricings_on_currency_code"
    t.index ["trip_id"], name: "index_trip_pricings_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "origin_airport_code", null: false
    t.string "destination_airport_code", null: false
    t.datetime "departure_at"
    t.datetime "arrival_at"
    t.integer "status", null: false
    t.decimal "luggage_capacity", precision: 5, scale: 2
    t.text "preference"
    t.citext "transporter_email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["arrival_at"], name: "index_trips_on_arrival_at"
    t.index ["departure_at"], name: "index_trips_on_departure_at"
    t.index ["destination_airport_code"], name: "index_trips_on_destination_airport_code"
    t.index ["origin_airport_code"], name: "index_trips_on_origin_airport_code"
    t.index ["status"], name: "index_trips_on_status"
    t.index ["transporter_email"], name: "index_trips_on_transporter_email"
  end

  create_table "users", primary_key: "email", id: :citext, force: :cascade do |t|
    t.citext "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "bookings", "currencies", column: "currency_code", primary_key: "code"
  add_foreign_key "cities", "countries", column: "country_code", primary_key: "code"
  add_foreign_key "package_pricings", "currencies", column: "currency_code", primary_key: "code"
  add_foreign_key "packages", "airports", column: "destination_airport_code", primary_key: "code"
  add_foreign_key "packages", "airports", column: "origin_airport_code", primary_key: "code"
  add_foreign_key "packages", "users", column: "dispatcher_email", primary_key: "email"
  add_foreign_key "trip_pricings", "currencies", column: "currency_code", primary_key: "code"
  add_foreign_key "trips", "airports", column: "destination_airport_code", primary_key: "code"
  add_foreign_key "trips", "airports", column: "origin_airport_code", primary_key: "code"
  add_foreign_key "trips", "users", column: "transporter_email", primary_key: "email"
end
