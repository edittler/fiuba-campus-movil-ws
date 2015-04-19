class RemoveProfileIdFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :profile_id, :integer
  end
end
