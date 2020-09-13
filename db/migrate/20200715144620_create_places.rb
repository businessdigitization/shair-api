class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.citext :name, null: false

      t.timestamps
    end
  end
end
