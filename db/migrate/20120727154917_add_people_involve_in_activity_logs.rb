class AddPeopleInvolveInActivityLogs < ActiveRecord::Migration
  add_column :activity_logs, :people_involved, :string
end
