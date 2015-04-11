class Job < ActiveRecord::Base

belongs_to :profile
has_one :date_interval, dependent: :destroy
end
