class RemoveZipFromCustomer < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :zip1, :string
    remove_column :customers, :zip2, :string
  end
end
