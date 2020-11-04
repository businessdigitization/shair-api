class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings, id: false do |t|
      t.string :number, primary_key: true
      t.references :trip, foreign_key: true
      t.references :parcel, foreign_key: true
      t.decimal :transporter_proposed_price, precision: 10, scale: 2
      t.decimal :dispatcher_proposed_price, precision: 10, scale: 2
      t.decimal :price, precision: 10, scale: 2
      t.string :currency_code, null:false, index: true
      t.integer :status, null: false
      t.timestamps
    end
    add_foreign_key :bookings, :currencies, column: :currency_code, primary_key: :code
  end
end
