class Api::Users::SessionsController < Api::ApiController

  # POST /api/users/sign_in
  def create
    # Fetch params
    email = params[:session][:email]
    password = params[:session][:password]

    if email.nil? or password.nil?
      render status: :bad_request,
             json: { result: "error", message: "Missing required parameters" }
      return
    end

    # Authentication
    user = User.find_by_email(email)

    if user
      if user.valid_password? password
        user.restore_authentication_token!
        # Note that the data which should be returned depends heavily of the API client needs.
        render status: :ok,
               json: { result: "ok", message: "Sign in success", user_token: user.authentication_token }
      else
        render status: :unauthorized,
               json: { result: "error", message: "Invalid email or password" }
      end
    else
      render status: :unauthorized,
             json: { result: "error", message: "Invalid email or password" }
    end
  end

  # DELETE /api/users/sign_out
  def destroy
    #TODO Validate required parameters
    logger.debug "[API] Session Destroy: #{params}"
    # Fetch params
    user = User.find_by(authentication_token: params[:user_token])

    if user.nil?
      render status: :not_found, json: { message: 'Invalid token' }
    else
      user.authentication_token = nil
      user.save!
      render status: :ok,
             json: { result: "ok", message: "Sign out succes" }
    end
  end

end
