class AddTimestampToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :last_update_time, :string
  end
end
