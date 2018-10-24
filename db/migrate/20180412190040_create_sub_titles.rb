class CreateSubTitles < ActiveRecord::Migration[5.1]
  def change
    create_table :sub_titles do |t|
      t.string :text
      t.integer :size

      t.timestamps
    end
  end
end
