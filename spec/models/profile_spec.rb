# == Schema Information
#
# Table name: profiles
#
#  id             :integer          not null, primary key
#  biography      :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  nationality_id :integer
#  city_id        :integer
#  phone_id       :integer
#  location_id    :integer
#  first_name     :string
#  last_name      :string
#  user_id        :integer
#
# Indexes
#
#  index_profiles_on_city_id         (city_id)
#  index_profiles_on_location_id     (location_id)
#  index_profiles_on_nationality_id  (nationality_id)
#  index_profiles_on_phone_id        (phone_id)
#  index_profiles_on_user_id         (user_id)
#

require 'rails_helper'

RSpec.describe Profile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
