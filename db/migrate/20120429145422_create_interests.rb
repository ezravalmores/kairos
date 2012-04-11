class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :name
      t.integer :interest_type_id
      t.integer :person_id
      
      t.timestamps
    end
  end
end
