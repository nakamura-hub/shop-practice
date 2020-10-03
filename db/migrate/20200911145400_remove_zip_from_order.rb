class RemoveZipFromOrder < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :zip1, :string
    remove_column :orders, :zip2, :string
  end
end
