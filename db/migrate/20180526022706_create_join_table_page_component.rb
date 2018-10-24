class CreateJoinTablePageComponent < ActiveRecord::Migration[5.1]
  def change
    create_join_table :pages, :components do |t|
      t.index [:page_id, :component_id]
    end
  end
end
