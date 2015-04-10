class Api::Friends::FriendshipRequestsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
    logger.debug "[API] Create Friendship Request Params: #{params}"
    @user = User.find(params[:user_id])
    logger.debug "[API] Sender User: #{@user.attributes.inspect}"
    @invited_user = User.find(params[:invited_user_id])
    logger.debug "[API] Invited User: #{@invited_user.attributes.inspect}"
    request_params = { sender_user_id:   @user.id,
                       receiver_user_id: @invited_user.id }
    @request = FriendshipRequest.new(request_params)
    logger.debug "[API] Friendship Request: #{@request}"

    if @request.save
      render status: :ok, json: { result: "ok", message: "Frienship Request Sent" }
    end
  end

end
