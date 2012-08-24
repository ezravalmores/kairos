class CreateOrganizations < ActiveRecord::Migration
  def up
    create_table :organizations do |t|
       t.string :name
       t.string :description
       t.timestamps
    end
  end
end
