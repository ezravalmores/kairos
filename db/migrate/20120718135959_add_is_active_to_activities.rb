class AddIsActiveToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :is_active, :boolean, :default => 1
  end
end
