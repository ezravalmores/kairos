class RemoveDepartmentAddActivityOnSpecificActivities < ActiveRecord::Migration
  def up
    add_column :specific_activities, :activity_id, :integer
  end

  def down
    remove_column :specific_activities, :department_id
  end
end
