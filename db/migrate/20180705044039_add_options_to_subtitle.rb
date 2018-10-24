class AddOptionsToSubtitle < ActiveRecord::Migration[5.1]
  def change
    add_column :sub_titles, :bottom_divider, :boolean, null: true
    add_column :sub_titles, :top_divider, :boolean, null: true
    add_column :sub_titles, :inset, :boolean, null: true
  end
end
