class AddRoleToPeople < ActiveRecord::Migration
  def change
    add_column :people, :role_id, :integer
  end
end
