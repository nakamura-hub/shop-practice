class AddReferencesToBrand < ActiveRecord::Migration[5.2]
  def change
    add_reference :brands, :product, foreign_key: true
  end
end
