class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :zip1
      t.string :zip2
      t.string :address
      t.string :tel
      t.integer :gender
      t.integer :born

      t.timestamps
    end
  end
end
