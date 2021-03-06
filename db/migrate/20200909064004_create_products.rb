class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.boolean :status, default: false, null: false
      t.text :description
      t.timestamps
    end
  end
end
