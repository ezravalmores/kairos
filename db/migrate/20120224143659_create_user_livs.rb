class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :user_livs do |t|
      t.datetime :schedule_date
      t.integer :leave_type_id
      t.string :reason
      t.boolean :is_submitted
      t.integer :updated_by
      
      t.timestamps
    end
  end
end
