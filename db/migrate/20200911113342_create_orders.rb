class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: true
      t.string :name
      t.string :email
      t.string :zip1
      t.string :zip2
      t.string :address
      t.string :tel

      t.timestamps
    end
  end
end
