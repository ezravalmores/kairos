class CreateInterestTypes < ActiveRecord::Migration
  def change
    create_table :interest_types do |t|
      t.string :name
      
      t.timestamps
    end
  end
end
