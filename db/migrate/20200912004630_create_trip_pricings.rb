class CreateTripPricings < ActiveRecord::Migration[6.0]
  def change
    create_table :trip_pricings do |t|
      t.references :trip, foreign_key: true
      t.decimal :unit_price, precision: 10, scale: 2, null: false
      t.decimal :minimum_price, precision: 10, scale: 2, null: false
      t.string :currency_code, null: false, index: true
      t.boolean :negotiable
    end
    add_foreign_key :trip_pricings, :currencies, column: :currency_code, primary_key: :code
  end
end
