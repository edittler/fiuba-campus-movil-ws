class RemoveNationalityIdFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :nationality_id, :integer
  end
end
