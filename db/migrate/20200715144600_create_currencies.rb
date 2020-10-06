class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies, id: false do |t|
      t.string :code, primary_key: true
      t.string :name, null: false
    end
  end
end
