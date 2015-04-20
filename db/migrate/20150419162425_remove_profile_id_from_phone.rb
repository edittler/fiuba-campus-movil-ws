class RemoveProfileIdFromPhone < ActiveRecord::Migration
  def change
    remove_column :phones, :profile_id, :integer
  end
end
