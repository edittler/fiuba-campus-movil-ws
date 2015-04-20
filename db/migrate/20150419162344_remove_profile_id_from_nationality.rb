class RemoveProfileIdFromNationality < ActiveRecord::Migration
  def change
    remove_column :nationalities, :profile_id, :integer
  end
end
