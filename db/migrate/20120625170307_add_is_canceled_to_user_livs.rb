class AddIsCanceledToUserLivs < ActiveRecord::Migration
  def change
    add_column :user_livs, :is_canceled, :boolean, :default => false
  end
end
