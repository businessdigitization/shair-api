class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.references :departure, foreign_key: { to_table: :airports, column: :departure_id }, null: false, index: true
      t.references :destination, foreign_key: { to_table: :airports, column: :destination_id }, null: false, index: true
      t.date :departure_on, index: true
      t.datetime :departure_at
      t.datetime :arrival_at
      t.integer :status, null: false, index: true
      t.decimal :luggage_capacity, precision: 5, scale: 2
      t.text :preference
      t.references :transporter, foreign_key: { to_table: :users, column: :transporter_id }, null: false, index: true
      t.timestamps
    end
  end
end
