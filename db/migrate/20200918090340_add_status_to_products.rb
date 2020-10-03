class AddStatusToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :status, :boolean, default: false, null: false
  end
end
