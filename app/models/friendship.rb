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

class Friendship < ActiveRecord::Base
  belongs_to :this_user,  class_name: "User"
  belongs_to :other_user, class_name: "User"
end
