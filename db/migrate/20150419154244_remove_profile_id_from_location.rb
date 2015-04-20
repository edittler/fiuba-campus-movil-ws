class RemoveProfileIdFromLocation < ActiveRecord::Migration
  def change
    remove_column :locations, :profile_id, :integer
  end
end
