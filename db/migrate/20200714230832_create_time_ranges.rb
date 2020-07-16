class CreateTimeRanges < ActiveRecord::Migration[6.0]
  def change
    create_table :time_ranges do |t|
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false

      t.timestamps
    end
  end
end
