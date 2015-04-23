# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  authentication_token   :string(255)
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, dependent: :destroy
  has_one :academic_info, dependent: :destroy

  # Friendship Request model relation
  has_many :sent_friendship_requests, class_name: "FriendshipRequest",
      foreign_key: "sender_user_id", dependent: :destroy
  has_many :received_friendship_requests, class_name: "FriendshipRequest",
      foreign_key: "receiver_user_id", dependent: :destroy

  # Friendship model relation
  has_many :friendships, foreign_key: "this_user_id", dependent: :destroy
  has_many :reverse_friendships, class_name: "Friendship",
      foreign_key: "other_user_id", dependent: :destroy

  # Friends model relation
  has_many :friends, through: :friendships, source: :other_user,
      after_add:    :create_complement_friendship,
      after_remove: :remove_complement_friendship

  # You likely have this before callback set up for the token.
  before_save :ensure_authentication_token

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def friend?(user)
    Friendship.exists?(this_user_id: self.id, other_user_id: user.id)
  end

  def friendship_request_pending?(user)
    FriendshipRequest.exists?(sender_user_id: user.id, receiver_user_id: self.id)
  end

  def friendship_request_sent?(user)
    FriendshipRequest.exists?(sender_user_id: self.id, receiver_user_id: user.id)
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
