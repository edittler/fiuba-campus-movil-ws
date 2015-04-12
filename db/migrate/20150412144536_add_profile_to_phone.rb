class AddProfileToPhone < ActiveRecord::Migration
  def change
    add_reference :phones, :profile, index: true, foreign_key: true
  end
end
