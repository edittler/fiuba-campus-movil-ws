# == Schema Information
#
# Table name: profiles
#
#  id             :integer          not null, primary key
#  biography      :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  nationality_id :integer
#  city_id        :integer
#  phone_id       :integer
#  location_id    :integer
#  first_name     :string
#  last_name      :string
#  user_id        :integer
#
# Indexes
#
#  index_profiles_on_city_id         (city_id)
#  index_profiles_on_location_id     (location_id)
#  index_profiles_on_nationality_id  (nationality_id)
#  index_profiles_on_phone_id        (phone_id)
#  index_profiles_on_user_id         (user_id)
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
