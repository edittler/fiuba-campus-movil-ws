class AddEducationToDateInterval < ActiveRecord::Migration
  def change
    add_reference :date_intervals, :education, index: true, foreign_key: true
  end
end
