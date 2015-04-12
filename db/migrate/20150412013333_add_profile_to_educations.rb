class AddProfileToEducations < ActiveRecord::Migration
  def change
    add_reference :educations, :profile, index: true, foreign_key: true
  end
end
