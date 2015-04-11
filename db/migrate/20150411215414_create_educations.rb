class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|

      t.timestamps null: false
    end
  end
end
