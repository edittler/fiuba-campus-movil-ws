# == Schema Information
#
# Table name: educations
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :integer
#
# Indexes
#
#  index_educations_on_profile_id  (profile_id)
#

class Education < ActiveRecord::Base

belongs_to :profile
has_one :institute
has_one :date_interval, dependent: :destroy
end