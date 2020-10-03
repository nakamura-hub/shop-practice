class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: true
      t.string :name
      t.string :email
      t.string :zip
      t.string :address
      t.string :tel
      t.integer :status, default: 0, null: false
      t.integer :sum
      t.timestamps
    end
  end
end
