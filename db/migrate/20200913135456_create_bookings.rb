class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.references :trip, index: true
      t.references :package, index: true
      t.decimal :transporter_proposed_price, precision: 10, scale: 2, null: false
      t.decimal :transiter_proposed_price, precision: 10, scale: 2, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.references :currency, index: true
      t.integer :status, null: false
      t.timestamps
    end
  end
end
