class CreateParcelItems < ActiveRecord::Migration[6.0]
  def change
    create_table :parcel_items do |t|
      t.string :name, null: false
      t.text :description
      t.integer :count, null: false, default: 1
      t.references :parcel, foreign_key: true
      t.integer :item_type_id, index: true

      t.timestamps
    end
    add_foreign_key :parcel_items, :parcel_item_types, column: :item_type_id

  end
end
