# == Schema Information
#
# Table name: profiles
#
#  id             :integer          not null, primary key
#  name           :string
#  biography      :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  nationality_id :integer
#  city_id        :integer
#  phone_id       :integer
#  location_id    :integer
#

require 'rails_helper'

RSpec.describe Profile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
