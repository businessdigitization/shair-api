class CreateTripPricings < ActiveRecord::Migration[6.0]
  def change
    create_table :trip_pricings do |t|
      t.references :trip, index: true
      t.decimal :unit_price, precision: 10, scale: 2, default: 0.00, null: false
      t.decimal :minimum_price, precision: 10, scale: 2, default: 0.00, null: false
      t.references :currency, index: true
      t.boolean :negotiable
    end
  end
end
