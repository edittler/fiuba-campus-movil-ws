class Api::Friends::FriendshipRequestsController < Api::ApiController

  # GET /api/friends/pending_friendship_requests
  def show
    user = User.find_by_authentication_token(params[:user_token])
    logger.debug "[API] User sender: #{user.attributes.inspect}"

    @pending_friendship_requests = user.received_friendship_requests
    logger.debug "[API] Pending friendship requests: #{@pending_friendship_requests.inspect}"

    render status: :ok
  end

  # POST /api/friends/send_friendship_request
  def create
    unless exists_create_required_params
      render_missing_required_params
      return
    end

    user = User.find_by_authentication_token(params[:user_token])
    logger.debug "[API] User sender: #{user.attributes.inspect}"

    user_to_invite_id = params[:user_to_invite_id]

    # TODO: Chequear si se quiere invitar a si mismo!

    unless User.exists?(user_to_invite_id)
      render status: :not_found,
             json: { result: "error", message: "User to invite no exists" }
      return
    end

    # TODO: Chequear si ya son amigos!!!

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

    friendship_request_id = params[:friendship_request_id]

    unless FriendshipRequest.exists?(friendship_request_id)
      render status: :not_found,
             json: { result: "error", message: "Friendship request no exists" }
      return
    end

    user = User.find_by_authentication_token(params[:user_token])
    logger.debug "[API] Receiver user: #{user.attributes.inspect}"

    friendship_request = FriendshipRequest.find(friendship_request_id)

    if user.id != friendship_request.receiver_user_id
      render status: :unauthorized,
             json: { result: "error", message: "Friendship request does not belong to the user" }
      return
    end

    unless friendship_request_reply_is_valid
      render status: :bad_request,
             json: { result: "error", message: "Friendship request response is invalid. Please, use '#{accept_response}' o '#{reject_response}' response." }
      return
    end

    if params[:friendship_request_response].eql? accept_response
      # Find sender user
      sender_user = User.find(friendship_request.sender_user_id)
      logger.debug "[API] Sender user: #{sender_user.attributes.inspect}"

      if sender_user.nil?
        render status: :bad_request,
               json: { result: "error", message: "Sender user not exists" }
        return
      end

      # Add friendships
      # TODO: chequear si ya son amigos
      user.friends << sender_user

      render status: :ok,
             json: { result: "ok", message: "Friendship request has been accepted" }
    else
      render status: :ok,
             json: { result: "ok", message: "Friendship request has been rejected" }
    end

    # Delete friendship request
    destroy_friendship_request friendship_request
  end

  private

    def exists_create_required_params
      return ( !params[:user_to_invite_id].nil? )
    end

    def exists_reply_required_params
      return !( params[:friendship_request_id].nil? or params[:friendship_request_response].nil? )
    end

    def accept_response
      return 'accept'
    end

    def reject_response
      return 'reject'
    end

    def friendship_request_reply_is_valid
      reply = params[:friendship_request_response]
      return ( (reply.eql? accept_response) or (reply.eql? reject_response) )
    end

    def destroy_friendship_request(friendship_request)
      friendship_request.destroy
    end


end
