class RemoveDateIntervalIdFromJobs < ActiveRecord::Migration
  def change
    remove_column :jobs, :date_interval_id, :datetime
  end
end
