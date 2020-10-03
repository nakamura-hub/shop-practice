class AddAuthToStaffs < ActiveRecord::Migration[5.2]
  def change
    add_column :staffs, :auth, :integer
  end
end
