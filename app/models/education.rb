# == Schema Information
#
# Table name: educations
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :integer
#  diploma    :string
#
# Indexes
#
#  index_educations_on_profile_id  (profile_id)
#

class Education < ActiveRecord::Base

belongs_to :profile
has_one :institute, dependent: :destroy, :autosave => true
has_one :date_interval, dependent: :destroy,:autosave => true
end
