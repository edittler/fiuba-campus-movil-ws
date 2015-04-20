# == Schema Information
#
# Table name: phones
#
#  id         :integer          not null, primary key
#  type       :string
#  number     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :integer
#

require 'rails_helper'

RSpec.describe Phone, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
