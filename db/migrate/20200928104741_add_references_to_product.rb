class AddReferencesToProduct < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :stock, foreign_key: true
    add_reference :products, :brand, foreign_key: true
  end
end
