class RemoveProductFromStock < ActiveRecord::Migration[5.2]
  def change
    remove_column :stocks, :product_id
  end
end
