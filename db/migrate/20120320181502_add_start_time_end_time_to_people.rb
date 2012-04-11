class AddStartTimeEndTimeToPeople < ActiveRecord::Migration
  def change
    add_column :people, :start_time, :time
    add_column :people, :end_time, :time
  end
end
