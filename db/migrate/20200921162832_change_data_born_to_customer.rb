class ChangeDataBornToCustomer < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :born, :date, 'date USING CAST(born AS date)'
  end
end
