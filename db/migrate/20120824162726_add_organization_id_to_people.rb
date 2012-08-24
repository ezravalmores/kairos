class AddOrganizationIdToPeople < ActiveRecord::Migration
  def change
    add_column :people, :organization_id, :integer
  end
end
