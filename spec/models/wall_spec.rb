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

require 'rails_helper'

RSpec.describe Wall, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
