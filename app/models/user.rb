class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :friends,
      class_name: "User",
      :join_table => "friendships",
      foreign_key: "this_user_id",
      association_foreign_key: "other_user_id",
      after_add:    :create_complement_friendship,
      after_remove: :remove_complement_friendship

  # You likely have this before callback set up for the token.
  before_save :ensure_authentication_token

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private
    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(authentication_token: token).first
      end
    end

    def create_complement_friendship(friend)
      friend.friends << self unless friend.friends.include?(self)
    end

    def remove_complement_friendship(friend)
      friend.friends.delete(self)
    end

end
