class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.references :customer, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
      t.index [:customer_id, :product_id], unique: true
    end
  end
end
