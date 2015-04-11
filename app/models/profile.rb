class Profile < ActiveRecord::Base

has_one :nationality, class_name:"Nationality"

has_one :city

has_one :phone, dependent: :destroy

has_one :location, dependent: :destroy

belongs_to :user

has_many :jobs, dependent: :destroy

has_many :educations, dependent: :destroy

end