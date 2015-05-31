# == Schema Information
#
# Table name: walls
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_walls_on_user_id  (user_id)
#

class Wall < ActiveRecord::Base
	belongs_to :user

	has_many :comments, dependent: :destroy
end
