class AddLengthToUserLivs < ActiveRecord::Migration
  def change
    add_column :user_livs, :length, :string
  end
end
