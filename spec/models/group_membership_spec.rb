# == Schema Information
#
# Table name: group_memberships
#
#  id              :integer          not null, primary key
#  membership_type :string
#  user_id         :integer
#  group_id        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_group_memberships_on_group_id  (group_id)
#  index_group_memberships_on_user_id   (user_id)
#

require 'rails_helper'

RSpec.describe GroupMembership, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
