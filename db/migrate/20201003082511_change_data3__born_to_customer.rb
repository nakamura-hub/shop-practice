class ChangeData3BornToCustomer < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column :customers, :born, :date, using: "born::date"
    end
  
    def down
      change_column :customers, :born, :text
    end
  end
end
