class AddProfileToJobs < ActiveRecord::Migration
  def change
    add_reference :jobs, :profile, index: true, foreign_key: true
  end
end
