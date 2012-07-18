class AddIsActiveToSpecificActivities < ActiveRecord::Migration
  def change
    add_column :specific_activities, :is_active, :boolean, :default => 1
  end
end
