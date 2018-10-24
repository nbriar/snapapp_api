class CreateTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :templates do |t|
      t.string :name

      t.timestamps
    end

    add_index :templates, [:name], unique: true
  end
end
