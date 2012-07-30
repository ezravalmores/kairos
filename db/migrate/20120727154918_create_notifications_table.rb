class CreateNotificationsTable < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :activity_log_id
      t.string :notification_log_type_type 
      t.integer :notification_log_type_id
      t.boolean :has_read, :default => false
      t.timestamps
    end
  end
end
