class AddZipToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :zip, :string
  end
end
