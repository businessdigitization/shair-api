class CreateAirports < ActiveRecord::Migration[6.0]
  def change
    create_table :airports do |t|
      t.string :name, null: false, index: true
      t.string :code, null: false, index: { unique: true }
      t.references :city, index: true
      t.timestamps
    end
  end
end
