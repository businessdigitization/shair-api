class CreatePackagePricings < ActiveRecord::Migration[6.0]
  def change
    create_table :package_pricings do |t|
      t.references :package, index: true
      t.decimal :price, precision: 10, scale: 2, default: 0.00, null: false
      t.references :currency, index: true
      t.boolean :negotiable
      t.timestamps
    end
  end
end
