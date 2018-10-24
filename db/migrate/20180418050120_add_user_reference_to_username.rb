class AddUserReferenceToUsername < ActiveRecord::Migration[5.1]
  def change
    add_column :auth_users, :auth_username_id, :integer, null: true
  end
end
