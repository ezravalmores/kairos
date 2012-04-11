class CreatePeopleTimes < ActiveRecord::Migration
  def change
    create_table :people_times do |t|
      t.integer :person_id
      t.integer :activity_id 
      t.time :start_time
      t.time :end_time
      t.time :total_time
      t.timestamps
    end
  end
end
