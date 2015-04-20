class AddEducationToInstitute < ActiveRecord::Migration
  def change
    add_reference :institutes, :education, index: true, foreign_key: true
  end
end
