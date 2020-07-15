class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.date :journey_date
      t.date :journey_date_range_start
      t.date :journey_date_range_end
      t.datetime :starts_at
      t.datetime :ends_at
      t.integer :status, null: false
      t.references :user, null: false
      t.references :route
      t.timestamps
    end
  end
end
