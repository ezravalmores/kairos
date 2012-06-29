class AddCanReceiveImportantMailsToPeople < ActiveRecord::Migration
  def change
    add_column :people, :can_receive_mails, :boolean, :default => false
  end
end
