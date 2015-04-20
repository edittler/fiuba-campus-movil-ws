# == Schema Information
#
# Table name: institutes
#
#  id           :integer          not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  education_id :integer
#
# Indexes
#
#  index_institutes_on_education_id  (education_id)
#

class Institute < ActiveRecord::Base

belongs_to :education
end
