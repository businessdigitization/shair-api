class CreatePackages < ActiveRecord::Migration[6.0]
  def change
    create_table :packages do |t|
      t.text :description
      t.string :origin_airport_code, null: false, index: true
      t.string :destination_airport_code, null: false, index: true
      t.decimal :weight, precision: 10, scale: 2
      t.integer :status, null: false
      t.text :preference
      t.citext :dispatcher_email, null: false, index: true
      t.daterange :delivery_daterange
      t.timestamps
    end
    add_foreign_key :packages, :airports, column: :origin_airport_code, primary_key: :code
    add_foreign_key :packages, :airports, column: :destination_airport_code, primary_key: :code
    add_foreign_key :packages, :users, column: :dispatcher_email, primary_key: :email
  end
end
