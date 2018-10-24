class CreateSpacers < ActiveRecord::Migration[5.1]
  def change
    create_table :spacers do |t|

      t.timestamps
    end
  end
end
