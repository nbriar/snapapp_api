class AddCollectionIndexToComponents < ActiveRecord::Migration[5.1]
  def change
    add_index :components, [:collection_id]
  end
end
