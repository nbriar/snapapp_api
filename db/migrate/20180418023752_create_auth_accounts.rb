class CreateAuthAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :auth_accounts do |t|
      t.string :name
      t.timestamps
    end

    add_index :auth_accounts, :name, :unique => true
  end
end
