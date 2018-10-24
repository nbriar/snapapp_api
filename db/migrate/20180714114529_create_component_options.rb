class CreateComponentOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :component_options do |t|
      t.integer :xs_width
      t.string :conditional_render

      t.timestamps
    end
  end
end
