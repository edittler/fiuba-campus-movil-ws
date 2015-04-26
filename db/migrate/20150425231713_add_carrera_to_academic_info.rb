class AddCarreraToAcademicInfo < ActiveRecord::Migration
  def change
    add_column :academic_infos, :carreer, :string
  end
end
