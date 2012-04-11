class AddApprovedByToPersonTimes < ActiveRecord::Migration
  def change
    add_column :person_times, :approved_by, :integer
  end
end
