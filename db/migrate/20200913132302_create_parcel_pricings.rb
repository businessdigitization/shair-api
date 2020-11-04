class CreateParcelPricings < ActiveRecord::Migration[6.0]
  def change
    create_table :parcel_pricings do |t|
      t.references :parcel, foreign_key: true
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string :currency_code, null: false, index: true
      t.boolean :negotiable
      t.timestamps
    end
    add_foreign_key :parcel_pricings, :currencies, column: :currency_code, primary_key: :code
  end
end
