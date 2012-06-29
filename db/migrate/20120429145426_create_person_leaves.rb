class CreatePersonLeaves < ActiveRecord::Migration
  def change
    create_table :user_livs do |t|
       t.integer :leave_type_id
       t.integer :person_id
       t.datetime :date
       t.string :reason
       t.boolean :is_approved
       t.integer :approved_by 
       t.timestamps
    end
  end
end
