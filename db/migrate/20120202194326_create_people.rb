class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
       t.string :first_name
       t.string :last_name
       t.string :email_address
       t.string :username
       t.string :password
       t.boolean :active, :default => true
       t.timestamps
    end
  end
end
