class AddWithPayIsSubmittedToUserLivs < ActiveRecord::Migration
  def change
    add_column :user_livs, :with_pay, :boolean, :default => false
    add_column :user_livs, :is_submitted, :boolean, :default => false
  end
end
