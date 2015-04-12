class Profile < ActiveRecord::Base

belongs_to :user

has_one :nationality

has_one :city

has_one :phone, dependent: :destroy

has_one :location, dependent: :destroy

has_many :jobs, dependent: :destroy

has_many :educations, dependent: :destroy

end