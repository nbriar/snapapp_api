class CreateAuthUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :auth_users do |t|
      t.string :email
      t.references :auth_account, foreign_key: true

      t.timestamps
    end

    add_index :auth_users, :email, :unique => true
  end
end
