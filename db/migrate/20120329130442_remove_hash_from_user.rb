class RemoveHashFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :password_hash
  end
end
