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

class Phone < ActiveRecord::Base

belongs_to :profile
end
