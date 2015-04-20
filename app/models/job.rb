# == Schema Information
#
# Table name: jobs
#
#  id         :integer          not null, primary key
#  company    :string
#  position   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :integer
#
# Indexes
#
#  index_jobs_on_profile_id  (profile_id)
#

class Job < ActiveRecord::Base

belongs_to :profile
has_one :date_interval, dependent: :destroy,:autosave => true

end
