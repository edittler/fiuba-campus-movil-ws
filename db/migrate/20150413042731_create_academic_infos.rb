class CreateAcademicInfos < ActiveRecord::Migration
  def change
    create_table :academic_infos do |t|
      t.string :padron
      t.timestamps null: false
    end
  end
end
