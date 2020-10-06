class CreatePackagePricings < ActiveRecord::Migration[6.0]
  def change
    create_table :package_pricings do |t|
      t.references :package, index: true
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string :currency_code, null: false, index: true
      t.boolean :negotiable
      t.timestamps
    end
    add_foreign_key :package_pricings, :currencies, column: :currency_code, primary_key: :code
  end
end
