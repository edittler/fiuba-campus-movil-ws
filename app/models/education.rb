class Education < ActiveRecord::Base

belongs_to :profile
has_one :institute
has_one :date_interval, dependent: :destroy
end
