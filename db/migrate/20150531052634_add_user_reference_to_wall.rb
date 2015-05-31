class AddUserReferenceToWall < ActiveRecord::Migration
  def change
    add_reference :walls, :user, index: true, foreign_key: true
  end
end
