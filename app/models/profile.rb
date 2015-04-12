# == Schema Information
#
# Table name: profiles
#
#  id             :integer          not null, primary key
#  name           :string
#  biography      :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  nationality_id :integer
#  city_id        :integer
#  phone_id       :integer
#  location_id    :integer
#

class Profile < ActiveRecord::Base

belongs_to :user

has_one :nationality

has_one :city

has_one :phone, dependent: :destroy

has_one :location, dependent: :destroy

has_many :jobs, dependent: :destroy

has_many :educations, dependent: :destroy

end
