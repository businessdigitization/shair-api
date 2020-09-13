class CreatePackageItems < ActiveRecord::Migration[6.0]
  def change
    create_table :package_items do |t|
      t.string :name, null: false
      t.text :description
      t.integer :count, null: false, default: 1
      t.references :package, index: true
      t.timestamps
    end
  end
end
