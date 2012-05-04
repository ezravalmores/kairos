class CreateTableTotalHours < ActiveRecord::Migration
  def up
    create_table :total_hours do |t|
       t.datetime :shift_date
       t.decimal :total_utilization_rate, :precision => 11, :scale => 2, :default => 0.0
       t.integer :person_id
       t.timestamps
    end
  end
end
