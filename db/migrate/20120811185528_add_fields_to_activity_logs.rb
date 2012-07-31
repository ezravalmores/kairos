class AddFieldsToActivityLogs < ActiveRecord::Migration
  def change
    add_column :activity_logs, :has_created_notifications, :boolean, :default => false
    add_column :activity_logs, :is_active, :boolean, :default => true
  end
end
