class CreatePackageItems < ActiveRecord::Migration[6.0]
  def change
    create_table :package_items do |t|
      t.string :name
      t.text :description
      t.integer :count
      t.references :package, index: true
      t.timestamps
    end
  end
end
