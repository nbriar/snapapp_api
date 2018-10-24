class CreateJoinTablePageCollection < ActiveRecord::Migration[5.1]
  def change
    create_join_table :pages, :collections do |t|
      t.index [:page_id, :collection_id]
    end
  end
end
