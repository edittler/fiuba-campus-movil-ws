class Api::Users::SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  # GET /resource/sign_in
#  def new
#    super
#  end

  # POST /resource/sign_in
  def create
    logger.debug "[API] Session Create: #{params}"
    # Fetch params
    email = params[:session][:email] if params[:session]
    password = params[:session][:password] if params[:session]

    id = User.find_by(email: email).try(:id) if email.presence

    # Validations
    if request.format != :json
      render status: :not_acceptable, json: { message: 'The request must be JSON.' }
      return
    end

    if email.nil? or password.nil?
      render status: :bad_request, json: { message: 'The request MUST contain the user email and password.' }
      return
    end

    # Authentication
    user = User.find_by(email: email)

    if user
      if user.valid_password? password
        user.restore_authentication_token!
        # Note that the data which should be returned depends heavily of the API client needs.
        render status: :ok, json: { email: user.email, user_token: user.authentication_token }
      else
        render status: :unauthorized, json: { message: 'Invalid email or password.' }
      end
    else
      render status: :unauthorized, json: { message: 'Invalid email or password.' }
    end
  end

  # DELETE /resource/sign_out
  def destroy
    logger.debug "[API] Session Destroy: #{params}"
    # Fetch params
    user = User.find_by(authentication_token: params[:user_token])

    if user.nil?
      render status: :not_found, json: { message: 'Invalid token.' }
    else
      user.authentication_token = nil
      user.save!
      render status: :ok, json: nil
    end
  end

end
