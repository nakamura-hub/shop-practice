class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :zip
      t.string :address
      t.string :tel
      t.integer :gender
      t.date :born

      t.timestamps
    end
  end
end
