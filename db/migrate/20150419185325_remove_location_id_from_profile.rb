class RemoveLocationIdFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :location_id, :integer
  end
end
