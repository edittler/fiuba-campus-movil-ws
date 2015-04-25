# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  biography  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  first_name :string
#  last_name  :string
#  user_id    :integer
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Profile, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
end
