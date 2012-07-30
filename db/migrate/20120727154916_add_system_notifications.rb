class AddSystemNotifications < ActiveRecord::Migration
  def change
    add_column :people, :system_notifications, :boolean, :default => false
  end
end
