# == Schema Information
#
# Table name: discussions
#
#  id         :integer          not null, primary key
#  subject    :string
#  forum_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_discussions_on_forum_id  (forum_id)
#  index_discussions_on_user_id   (user_id)
#

class Discussion < ActiveRecord::Base
  belongs_to :forum
  has_many :comments
  belongs_to :user
end
