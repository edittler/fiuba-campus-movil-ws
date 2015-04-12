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
# Indexes
#
#  index_friendship_requests_on_receiver_user_id  (receiver_user_id)
#  index_friendship_requests_on_sender_user_id    (sender_user_id)
#

class FriendshipRequest < ActiveRecord::Base
  belongs_to :sender_user,   class_name: "User"
  belongs_to :receiver_user, class_name: "User"
end
