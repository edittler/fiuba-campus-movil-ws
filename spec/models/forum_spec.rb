# == Schema Information
#
# Table name: forums
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  group_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_forums_on_group_id  (group_id)
#

require 'rails_helper'

RSpec.describe Forum, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
