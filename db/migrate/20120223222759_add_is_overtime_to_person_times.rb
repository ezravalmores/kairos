class AddIsOvertimeToPersonTimes < ActiveRecord::Migration
  def change
    add_column :person_times, :is_overtime, :integer
  end
end
