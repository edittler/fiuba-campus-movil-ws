# == Schema Information
#
# Table name: phones
#
#  id         :integer          not null, primary key
#  type       :string
#  number     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :integer
#
# Indexes
#
#  index_phones_on_profile_id  (profile_id)
#

class Phone < ActiveRecord::Base

belongs_to :profile
end
