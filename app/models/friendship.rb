class Friendship < ActiveRecord::Base
  belongs_to :this_user,  class_name: "User"
  belongs_to :other_user, class_name: "User"
end
