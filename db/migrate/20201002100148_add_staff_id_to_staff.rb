class AddStaffIdToStaff < ActiveRecord::Migration[5.2]
  def change
    add_column :staffs, :staff_id, :string
  end
end
