class Api::Friends::FriendshipsController < Api::ApiController

  def show
    unless exists_user_token_param(params)
      render_missing_user_token_parameter
      return
    end

    user = User.find_by(authentication_token: params[:user_token])

    if user.nil?
      render_invalid_user_token
      return
    end

    @friends = User.all
    render status: :ok
  end

  def add_friend
    logger.debug "[API] Add Friend: #{params}"
    @user = User.find(params[:user_id])
    logger.debug "[API] User: #{@user.attributes.inspect}"
    @friend = User.find(params[:friend_user_id])
    logger.debug "[API] Friend: #{@friend.attributes.inspect}"
    logger.debug "[API] User Friends: #{@user.friends}"

    #if user & friend
      @user.friends << @friend
      render status: :ok, json: { result: "ok", message: "Friens added" }
    #end
  end

end
