class AddOrganizationIdToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :organization_id, :integer
  end
end
