class CreateActivityLogs < ActiveRecord::Migration
  def change
    create_table :activity_logs do |t|
      t.integer :person_id
      t.string :activity_log_type_type 
      t.integer :activity_log_type_id
      t.datetime :date
      t.timestamps
    end
  end
end
