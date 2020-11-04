class CreateAirports < ActiveRecord::Migration[6.0]
  def change
    create_table :airports, id: false do |t|
      t.string :name, null: false, index: true
      t.string :code, primary_key: true
      t.references :city, foreign_key: true
      t.timestamps
    end
  end
end
