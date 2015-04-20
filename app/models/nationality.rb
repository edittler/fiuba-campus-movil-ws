# == Schema Information
#
# Table name: nationalities
#
#  id          :integer          not null, primary key
#  nationality :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  profile_id  :integer
#

class Nationality < ActiveRecord::Base
belongs_to :profile
end
