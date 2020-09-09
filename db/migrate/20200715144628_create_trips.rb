class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.references :departure, foreign_key: { to_table: :places, column: :departure_id }, null: false, index: true
      t.references :destination, foreign_key: { to_table: :places, column: :destination_id }, null: false, index: true
      t.date :date, index: true
      t.datetime :departure_time
      t.datetime :arrival_time
      t.integer :status, null: false, index: true
      t.integer :trip_type
      t.decimal :luggage_capacity, precision: 5, scale: 2
      t.references :user, null: false, index: true
      t.timestamps
    end
  end
end
