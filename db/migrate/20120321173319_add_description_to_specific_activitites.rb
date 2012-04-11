class AddDescriptionToSpecificActivitites < ActiveRecord::Migration
  def change
    add_column :specific_activities, :description, :string
  end
end
