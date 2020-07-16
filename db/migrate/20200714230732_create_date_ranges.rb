class CreateDateRanges < ActiveRecord::Migration[6.0]
  def change
    create_table :date_ranges do |t|
      t.date :starts_at, null: false
      t.date :ends_at, null: false

      t.timestamps
    end
  end
end
