class AddStaffIdToStaff < ActiveRecord::Migration[5.2]
  def change
    add_column :staffs, :staff_id, :string, null: false
  end
end
