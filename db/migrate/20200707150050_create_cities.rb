class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.string :name, null: false
      t.string :country_code, null: false, index: true
      t.timestamps
    end
    add_foreign_key :cities, :countries, column: :country_code, primary_key: :code
  end
end
