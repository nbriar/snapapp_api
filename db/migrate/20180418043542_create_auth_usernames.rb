class CreateAuthUsernames < ActiveRecord::Migration[5.1]
  def change
    create_table :auth_usernames do |t|
      t.string :name
      t.string :password
      t.references :auth_user, foreign_key: true

      t.timestamps
    end

    add_index :auth_usernames, :name, :unique => true
  end
end
