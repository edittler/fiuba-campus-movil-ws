class RemovePhoneIdFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :phone_id, :integer
  end
end
