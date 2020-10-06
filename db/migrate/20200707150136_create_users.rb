class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'citext'

    create_table :users, id: false do |t|
      t.citext :name
      t.citext :email, primary_key: true
      t.timestamps
    end
  end
end
