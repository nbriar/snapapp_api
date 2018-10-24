class CreateHyperlinks < ActiveRecord::Migration[5.1]
  def change
    create_table :hyperlinks do |t|
      t.string :url, required: true
      t.string :text
      t.string :target
      t.string :action

      t.timestamps
    end
  end
end
