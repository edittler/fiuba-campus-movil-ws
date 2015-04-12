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
# Indexes
#
#  index_friendships_on_other_user_id  (other_user_id)
#  index_friendships_on_this_user_id   (this_user_id)
#

class Friendship < ActiveRecord::Base
  belongs_to :this_user,  class_name: "User"
  belongs_to :other_user, class_name: "User"
end
