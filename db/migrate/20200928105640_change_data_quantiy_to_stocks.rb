class ChangeDataQuantiyToStocks < ActiveRecord::Migration[5.2]
  def change
    change_column :stocks, :quantity, :integer
  end
end
