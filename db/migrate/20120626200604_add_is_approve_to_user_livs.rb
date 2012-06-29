class AddIsApproveToUserLivs < ActiveRecord::Migration
  def change
    add_column :user_livs, :is_approved, :boolean, :default => false
  end
end
