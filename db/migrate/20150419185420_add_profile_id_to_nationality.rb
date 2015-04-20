class AddProfileIdToNationality < ActiveRecord::Migration
  def change
    add_column :nationalities, :profile_id, :integer
  end
end
