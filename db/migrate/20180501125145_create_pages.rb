class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.string :title
      t.string :route
      t.references :customer_app

      t.timestamps
    end
  end
end
