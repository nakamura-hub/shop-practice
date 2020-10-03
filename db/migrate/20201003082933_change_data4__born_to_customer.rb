class ChangeData4BornToCustomer < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :born, :date, USING: born::date
  end
end
