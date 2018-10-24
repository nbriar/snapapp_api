class AddAppIdToCollection < ActiveRecord::Migration[5.1]
  def change
    add_column :collections, :app_id, :string, required: true
  end
end
