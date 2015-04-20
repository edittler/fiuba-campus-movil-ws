class RemoveProfileIdFromCity < ActiveRecord::Migration
  def change
    remove_column :cities, :profile_id, :integer
  end
end
