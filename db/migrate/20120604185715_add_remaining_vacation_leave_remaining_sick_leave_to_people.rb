class AddRemainingVacationLeaveRemainingSickLeaveToPeople < ActiveRecord::Migration
  def change
    add_column :people, :remaining_vacation_leave, :integer
    add_column :people, :remaining_sick_leave, :integer
  end
end
