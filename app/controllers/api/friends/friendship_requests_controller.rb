class Api::Friends::FriendshipRequestsController < Api::ApiController

  # POST /api/friends/send_friendship_request
  def create
    logger.debug "[API] Create Friendship Request Params: #{params}"
    #user = User.find(params[:user_id])
    #logger.debug "[API] Sender User: #{user.attributes.inspect}"
    #invited_user = User.find(params[:invited_user_id])
    #logger.debug "[API] Invited User: #{invited_user.attributes.inspect}"
    #request_params = { sender_user_id:   user.id,
    #                   receiver_user_id: invited_user.id }
    #request = FriendshipRequest.new(request_params)
    #logger.debug "[API] Friendship Request: #{request}"

    #if request.save
    #  render status: :ok, json: { result: "ok", message: "Frienship Request Sent" }
    #end

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
    logger.debug "[API] User sent requests: #{user.sent_friendship_requests.inspect}"

    # TODO: chequear si el usuario ya envió invitacion al otro usuario

    request_params = { sender_user_id:   user.id,
                       receiver_user_id: user_to_invite_id }
    friendship_request = FriendshipRequest.create(request_params)

    render status: :ok,
           json: { result: "ok", message: "Frienship request sent" }
  end

  private

    def exists_create_required_params
      return ( !params[:user_to_invite_id].nil? )
    end

end
