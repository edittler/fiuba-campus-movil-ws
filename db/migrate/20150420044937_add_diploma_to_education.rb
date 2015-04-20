class AddDiplomaToEducation < ActiveRecord::Migration
  def change
    add_column :educations, :diploma, :string
  end
end
