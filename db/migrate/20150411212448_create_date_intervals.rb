class CreateDateIntervals < ActiveRecord::Migration
  def change
    create_table :date_intervals do |t|
      t.datetime :init
      t.datetime :end

      t.timestamps null: false
    end
  end
end
