class AddProfileToCity < ActiveRecord::Migration
  def change
    add_reference :cities, :profile, index: true, foreign_key: true
  end
end
