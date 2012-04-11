class AddSubmittedApprovedToPersonTimes < ActiveRecord::Migration
  def change
    add_column :person_times, :is_submitted, :boolean
    add_column :person_times, :is_approved, :boolean
    add_column :person_times, :role_id, :integer  
  end
end
