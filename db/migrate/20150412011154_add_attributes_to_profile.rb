class AddAttributesToProfile < ActiveRecord::Migration
  def change
    add_reference :profiles, :nationality, index: true, foreign_key: true
    add_reference :profiles, :city, index: true, foreign_key: true
    add_reference :profiles, :phone, index: true, foreign_key: true
    add_reference :profiles, :location, index: true, foreign_key: true
  end
end
