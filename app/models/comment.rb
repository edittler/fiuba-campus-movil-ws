# == Schema Information
#
# Table name: comments
#
#  id            :integer          not null, primary key
#  text          :text
#  user_id       :integer
#  discussion_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_comments_on_discussion_id  (discussion_id)
#  index_comments_on_user_id        (user_id)
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :discussion
end
