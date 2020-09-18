class CreatePackages < ActiveRecord::Migration[6.0]
  def change
    create_table :packages do |t|
      t.text :description
      t.references :departure, foreign_key: { to_table: :airports, column: :departure_id }, null: false, index: true
      t.references :destination, foreign_key: { to_table: :airports, column: :destination_id }, null: false, index: true
      t.decimal :weight, precision: 10, scale: 2
      t.integer :status, null: false
      t.integer :delivery_status
      t.text :preference
      t.references :transiter, foreign_key: { to_table: :users, column: :transiter_id }, null: false, index: true
      t.daterange :delivery_daterange

      t.timestamps
    end
  end
end
