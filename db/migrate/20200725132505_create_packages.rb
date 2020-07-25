class CreatePackages < ActiveRecord::Migration[6.0]
  def change
    create_table :packages do |t|
      t.text :description
      t.references :departure, foreign_key: { to_table: :places, column: :departure_id }, null: false, index: true
      t.references :destination, foreign_key: { to_table: :places, column: :destination_id }, null: false, index: true
      t.decimal :weight, precision: 10, scale: 2
      t.integer :status, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
