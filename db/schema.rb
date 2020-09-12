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

ActiveRecord::Schema.define(version: 2020_09_12_004630) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "currencies", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.index ["code"], name: "index_currencies_on_code"
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

  create_table "packages", force: :cascade do |t|
    t.text "description"
    t.bigint "departure_id", null: false
    t.bigint "destination_id", null: false
    t.decimal "weight", precision: 10, scale: 2
    t.integer "status", null: false
    t.integer "delivery_status"
    t.text "preference"
    t.bigint "user_id", null: false
    t.daterange "delivery_daterange"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["departure_id"], name: "index_packages_on_departure_id"
    t.index ["destination_id"], name: "index_packages_on_destination_id"
    t.index ["user_id"], name: "index_packages_on_user_id"
  end

  create_table "places", force: :cascade do |t|
    t.citext "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trip_pricings", force: :cascade do |t|
    t.bigint "trip_id"
    t.decimal "unit_price", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "minimum_price", precision: 10, scale: 2, default: "0.0", null: false
    t.bigint "currency_id"
    t.boolean "negotiable"
    t.index ["currency_id"], name: "index_trip_pricings_on_currency_id"
    t.index ["trip_id"], name: "index_trip_pricings_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.bigint "departure_id", null: false
    t.bigint "destination_id", null: false
    t.date "date"
    t.datetime "departure_time"
    t.datetime "arrival_time"
    t.integer "status", null: false
    t.integer "trip_type"
    t.decimal "luggage_capacity", precision: 5, scale: 2
    t.text "preference"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["date"], name: "index_trips_on_date"
    t.index ["departure_id"], name: "index_trips_on_departure_id"
    t.index ["destination_id"], name: "index_trips_on_destination_id"
    t.index ["status"], name: "index_trips_on_status"
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.citext "name"
    t.citext "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "packages", "places", column: "departure_id"
  add_foreign_key "packages", "places", column: "destination_id"
  add_foreign_key "trips", "places", column: "departure_id"
  add_foreign_key "trips", "places", column: "destination_id"
end
