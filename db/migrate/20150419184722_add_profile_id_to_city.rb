class AddProfileIdToCity < ActiveRecord::Migration
  def change
    add_column :cities, :profile_id, :integer
  end
end
