# == Schema Information
#
# Table name: date_intervals
#
#  id         :integer          not null, primary key
#  init       :datetime
#  end        :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  job_id     :integer
#
# Indexes
#
#  index_date_intervals_on_job_id  (job_id)
#

class DateInterval < ActiveRecord::Base

belongs_to :job,:autosave => true
end
