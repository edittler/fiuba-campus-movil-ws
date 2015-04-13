class AddUserToAcademicInfo < ActiveRecord::Migration
  def change
    add_reference :academic_infos, :user, index: true, foreign_key: true
  end
end
