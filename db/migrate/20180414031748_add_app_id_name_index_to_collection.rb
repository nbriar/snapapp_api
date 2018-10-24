class AddAppIdNameIndexToCollection < ActiveRecord::Migration[5.1]
  def change
    add_index :collections, [:app_id, :name], unique: true  
  end
end
