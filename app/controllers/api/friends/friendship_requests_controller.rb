class Api::Friends::FriendshipRequestsController < Api::ApiController

  # POST /api/friends/send_friendship_request
  def create
    unless exists_create_required_params
      render_missing_required_params
      return
    end

    user = User.find_by_authentication_token(params[:user_token])
    logger.debug "[API] User sender: #{user.attributes.inspect}"

    user_to_invite_id = params[:user_to_invite_id]

    unless User.exists?(user_to_invite_id)
      render status: :not_found,
             json: { result: "error", message: "User to invite no exists" }
      return
    end

    user_to_invite = User.find(user_to_invite_id)
    logger.debug "[API] User to invite: #{user_to_invite.attributes.inspect}"

    request_params = { sender_user_id:   user.id,
                       receiver_user_id: user_to_invite_id }

    if FriendshipRequest.exists?(request_params)
      render status: :conflict,
             json: { result: "error", message: "Frienship request has been sent" }
      return
    end

    FriendshipRequest.create(request_params)

    render status: :ok,
           json: { result: "ok", message: "Frienship request sent" }
  end

# POST /api/friends/respond_friendship_request
  def reply
    unless exists_reply_required_params
      render_missing_required_params
      return
    end

    unless FriendshipRequest.exists?(params[:friendship_request_id])
      render status: :not_found,
             json: { result: "error", message: "Friendship request no exists" }
      return
    end

    user = User.find_by_authentication_token(params[:user_token])
    logger.debug "[API] User sender: #{user.attributes.inspect}"

    friendship_request = FriendshipRequest.find(params[:friendship_request_id])

    render status: :ok,
           json: { result: "ok", message: "okkkk" }

  end

  private

    def exists_create_required_params
      return ( !params[:user_to_invite_id].nil? )
    end

    def exists_reply_required_params
      return !( params[:friendship_request_id].nil? or params[:friendship_request_response].nil? )
    end

end
