class AddCanViewToAllOrganization < ActiveRecord::Migration
  def change
      add_column :activities, :can_view_to_all_org, :boolean, :default => false
  end
end
