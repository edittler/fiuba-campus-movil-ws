class AddJobIdToDateIntervals < ActiveRecord::Migration
  def change
    add_column :date_intervals, :job_id, :integer
  end
end
