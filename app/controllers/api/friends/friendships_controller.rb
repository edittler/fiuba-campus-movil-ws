class Api::Friends::FriendshipsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def add_friend
    logger.debug "[API] Add Friend: #{params}"
    user = User.find(params[:user_id])
    friend = User.find(params[:friend_user_id])

    #if user & friend
      user.friends << friend
      render status: :ok, json: { result: "ok", message: "Friens added" }
    #end
  end
end
