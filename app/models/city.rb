# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :integer
#
# Indexes
#
#  index_cities_on_profile_id  (profile_id)
#

class City < ActiveRecord::Base
belongs_to :profile
end
