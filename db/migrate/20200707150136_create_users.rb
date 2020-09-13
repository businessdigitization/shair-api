class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'citext'

    create_table :users do |t|
      t.citext :name
      t.citext :email

      t.timestamps
    end
  end
end
