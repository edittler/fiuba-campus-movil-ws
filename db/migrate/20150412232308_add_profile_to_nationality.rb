class AddProfileToNationality < ActiveRecord::Migration
  def change
    add_reference :nationalities, :profile, index: true, foreign_key: true
  end
end
