class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.string :origin_airport_code, null: false, index: true
      t.string :destination_airport_code, null: false, index: true
      t.datetime :departure_at, index: true
      t.datetime :arrival_at, index: true
      t.integer :status, null: false, index: true
      t.decimal :luggage_capacity, precision: 5, scale: 2
      t.text :preference
      t.citext :transporter_email, null: false, index: true
      t.timestamps
    end
    add_foreign_key :trips, :airports, column: :origin_airport_code, primary_key: :code
    add_foreign_key :trips, :airports, column: :destination_airport_code, primary_key: :code
    add_foreign_key :trips, :users, column: :transporter_email, primary_key: :email
  end
end
