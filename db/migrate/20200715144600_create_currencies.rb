class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies do |t|
      t.string :code, null: false, unique: true, index: true
      t.string :name, null: false
    end
  end
end
