class AddExternalIdToAuthUser < ActiveRecord::Migration[5.1]
  def change
    add_column :auth_users, :external_id, :string, null: true
  end
end
