class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.text :departure
      t.text :destination
      t.date :date
      t.datetime :departure_time
      t.datetime :arrival_time
      t.integer :status, null: false
      t.integer :trip_type
      t.references :user, null: false
      t.timestamps
    end
  end
end
