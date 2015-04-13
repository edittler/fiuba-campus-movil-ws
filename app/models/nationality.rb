# == Schema Information
#
# Table name: nationalities
#
#  id          :integer          not null, primary key
#  nationality :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  profile_id  :integer
#
# Indexes
#
#  index_nationalities_on_profile_id  (profile_id)
#

class Nationality < ActiveRecord::Base
belongs_to :profile
end
