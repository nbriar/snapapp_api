class CreateCustomerApps < ActiveRecord::Migration[5.1]
  def change
    create_table :customer_apps do |t|
      t.string :name
      t.string :slug
      t.references :auth_account



      t.timestamps
    end
  end
end
