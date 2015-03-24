class Api::Users::SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  # GET /resource/sign_in
#  def new
#    super
#  end

  # POST /resource/sign_in
  def create
    logger.info "[API] Session Create #{params}"
    #super
    render json: {:status => "OK"}, status: :ok # :bad_request
  end

end
