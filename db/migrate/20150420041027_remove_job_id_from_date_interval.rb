class RemoveJobIdFromDateInterval < ActiveRecord::Migration
  def change
    remove_column :date_intervals, :job_id, :integer
  end
end
