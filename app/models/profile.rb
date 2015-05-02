# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  biography  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  first_name :string
#  last_name  :string
#  user_id    :integer
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#

class Profile < ActiveRecord::Base
  belongs_to :user
  has_one :nationality, dependent: :destroy
  has_one :city, dependent: :destroy
  has_one :phone, dependent: :destroy
  has_one :location, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :educations, dependent: :destroy
end
