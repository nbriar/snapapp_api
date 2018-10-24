class CreateComponents < ActiveRecord::Migration[5.1]
  def change
    create_table :components do |t|
      t.string :app_id, required: true
      t.integer :collection_id
      t.integer :element_id, required: true
      t.string :element_type, required: true
      t.string :name, required: true

      t.timestamps
    end

    add_index :components, [:app_id, :name], unique: true
  end
end
