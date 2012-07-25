class CreatNccmActivities < ActiveRecord::Migration
  def change
    create_table :ncmm_activities do |t|
      t.integer :person_id
      t.string :activity
      t.string :description
      t.boolean :is_active, :default => true
      t.date :date
      t.timestamps
    end
  end
end
