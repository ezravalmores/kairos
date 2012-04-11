class AddUpdatedByToPersonTimes < ActiveRecord::Migration
  def change
    add_column :person_times, :updated_by, :integer
  end
end
