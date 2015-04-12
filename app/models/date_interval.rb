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

class DateInterval < ActiveRecord::Base

end
