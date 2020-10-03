class ChangeData2BornToCustomer < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :born, :text
  end
end
