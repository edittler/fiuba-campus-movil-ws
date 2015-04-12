class AddJobToDateInterval < ActiveRecord::Migration
  def change
    add_reference :date_intervals, :job, index: true, foreign_key: true
  end
end
