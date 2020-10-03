class ChangeDataBornToCustomer < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :born, :date
  end
end
