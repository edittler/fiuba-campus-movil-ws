class AddDateIntervalToJob < ActiveRecord::Migration
  def change
    add_reference :jobs, :job, index: true, foreign_key: true
  end
end
