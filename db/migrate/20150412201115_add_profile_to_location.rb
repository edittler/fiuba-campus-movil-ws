class AddProfileToLocation < ActiveRecord::Migration
  def change
    add_reference :locations, :profile, index: true, foreign_key: true
  end
end
