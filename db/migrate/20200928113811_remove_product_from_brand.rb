class RemoveProductFromBrand < ActiveRecord::Migration[5.2]
  def change
    remove_column :brands, :product_id
  end
end
