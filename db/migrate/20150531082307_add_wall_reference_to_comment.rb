class AddWallReferenceToComment < ActiveRecord::Migration
  def change
    add_reference :comments, :wall, index: true, foreign_key: true
  end
end
