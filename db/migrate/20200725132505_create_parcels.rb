class CreateParcels < ActiveRecord::Migration[6.0]
  def change
    create_table :parcels do |t|
      t.text :description
      t.string :origin_airport_code, null: false, index: true
      t.string :destination_airport_code, null: false, index: true
      t.decimal :weight, precision: 10, scale: 2
      t.integer :status, null: false
      t.text :preference
      t.citext :dispatcher_email, null: false, index: true
      t.timestamps
    end
    add_foreign_key :parcels, :airports, column: :origin_airport_code, primary_key: :code
    add_foreign_key :parcels, :airports, column: :destination_airport_code, primary_key: :code
    add_foreign_key :parcels, :users, column: :dispatcher_email, primary_key: :email
  end
end
