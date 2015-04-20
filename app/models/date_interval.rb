# == Schema Information
#
# Table name: date_intervals
#
#  id           :integer          not null, primary key
#  init         :datetime
#  end          :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  job_id       :integer
#  education_id :integer
#
# Indexes
#
#  index_date_intervals_on_education_id  (education_id)
#

class DateInterval < ActiveRecord::Base

belongs_to :job,:autosave => true
belongs_to :education,:autosave => true
end
