class CreateRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :routes do |t|
      t.string :from, null: false
      t.string :to, null: false
      t.integer :route_type
      t.timestamps
    end
  end
end
