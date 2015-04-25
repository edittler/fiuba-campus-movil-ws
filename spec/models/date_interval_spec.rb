# == Schema Information
#
# Table name: date_intervals
#
#  id           :integer          not null, primary key
#  init         :datetime
#  end          :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  job_id       :integer
#  education_id :integer
#
# Indexes
#
#  index_date_intervals_on_education_id  (education_id)
#

require 'rails_helper'

RSpec.describe DateInterval, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
end
