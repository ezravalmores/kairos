class AddIsActivePlannedToUserLivs < ActiveRecord::Migration
  def change
    add_column :user_livs, :planned, :boolean
    add_column :user_livs, :is_active, :boolean, :default => true
  end
end
