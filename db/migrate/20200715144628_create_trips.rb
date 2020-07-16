class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.date :journey_date
      t.references :date_range
      t.references :time_range
      t.integer :status, null: false
      t.references :user, null: false
      t.references :route
      t.timestamps
    end
  end
end
