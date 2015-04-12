# == Schema Information
#
# Table name: friendships
#
#  id            :integer          not null, primary key
#  this_user_id  :integer          not null
#  other_user_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
