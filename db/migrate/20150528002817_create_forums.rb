class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :title
      t.text :description
      t.references :group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
