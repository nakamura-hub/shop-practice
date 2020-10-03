class RemoveStockFromProduct < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :stock_id
  end
end
