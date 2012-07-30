class AddPersonIdInNotificationsTable < ActiveRecord::Migration
  def change
    add_column :notifications, :person_id, :integer
  end
end
