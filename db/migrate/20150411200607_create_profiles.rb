class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :user, index: true
      t.string :first_name
      t.string :last_name
      t.string :biography
      t.timestamps null: false
    end
  end
end
