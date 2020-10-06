class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries, id: false do |t|
      t.string :name, null: false
      t.string :code, primary_key: true
      t.timestamps
    end
  end
end
