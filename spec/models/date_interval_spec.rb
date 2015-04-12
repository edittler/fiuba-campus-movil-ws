# == Schema Information
#
# Table name: date_intervals
#
#  id         :integer          not null, primary key
#  init       :datetime
#  end        :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe DateInterval, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
