class AddSumToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :sum, :integer
  end
end
