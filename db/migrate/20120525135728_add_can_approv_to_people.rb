class AddCanApprovToPeople < ActiveRecord::Migration
  def change
     add_column :people, :can_approve, :boolean, :default => false
  end
end
