class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.datetime :schedule_date
      t.integer :leave_type_id
      t.string :reason
      t.boolean :is_submitted
      t.boolean :is_approved
      t.integer :updated_by
      
      t.timestamps
    end
  end
end
