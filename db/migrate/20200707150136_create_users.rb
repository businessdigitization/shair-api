class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'citext'

    create_table :users, id: false do |t|
      t.citext :name, null: false
      t.citext :email, primary_key: true
      t.string :password_digest, null: false
      t.timestamps
    end
  end
end
