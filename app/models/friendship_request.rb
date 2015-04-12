# == Schema Information
#
# Table name: friendship_requests
#
#  id               :integer          not null, primary key
#  sender_user_id   :integer          not null
#  receiver_user_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class FriendshipRequest < ActiveRecord::Base
  belongs_to :sender_user,   class_name: "User"
  belongs_to :receiver_user, class_name: "User"
end
