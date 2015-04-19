class AddProfileIdToPhone < ActiveRecord::Migration
  def change
    add_column :phones, :profile_id, :integer
  end
end
