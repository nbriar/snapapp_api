class CreateTemplateElements < ActiveRecord::Migration[5.1]
  def change
    create_table :template_elements do |t|
      t.string :element_type
      t.integer :ordinal
      t.references :template

      t.timestamps
    end
  end
end
