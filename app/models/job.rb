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

class Job < ActiveRecord::Base

belongs_to :profile
has_one :date_interval, dependent: :destroy
end
