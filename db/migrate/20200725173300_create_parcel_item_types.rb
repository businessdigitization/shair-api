class CreateParcelItemTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :parcel_item_types do |t|
      t.string :name, null: false
      t.string :description
      t.timestamps
    end
  end
end
