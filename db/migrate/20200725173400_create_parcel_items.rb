class CreateParcelItems < ActiveRecord::Migration[6.0]
  def change
    create_table :parcel_items do |t|
      t.string :name, null: false
      t.text :description
      t.integer :count, null: false, default: 1
      t.references :parcel, index: true
      t.timestamps
    end
  end
end
