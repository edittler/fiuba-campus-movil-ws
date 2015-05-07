# == Schema Information
#
# Table name: profiles
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  first_name           :string
#  last_name            :string
#  biography            :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#

class Profile < ActiveRecord::Base
  belongs_to :user

  has_attached_file :picture,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => ""
  validates_attachment_content_type :picture,
                                    :content_type => /\Aimage\/.*\Z/

  has_one :nationality, dependent: :destroy
  has_one :city, dependent: :destroy
  has_one :phone, dependent: :destroy
  has_one :location, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :educations, dependent: :destroy
end
