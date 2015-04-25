# == Schema Information
#
# Table name: group_memberships
#
#  id              :integer          not null, primary key
#  member_type     :string
#  member_id       :integer
#  group_id        :integer
#  membership_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_group_memberships_on_group_id                   (group_id)
#  index_group_memberships_on_member_id_and_member_type  (member_id,member_type)
#

require 'rails_helper'

RSpec.describe GroupMembership, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
end
