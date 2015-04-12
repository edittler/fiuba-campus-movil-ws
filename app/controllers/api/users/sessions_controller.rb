class Api::Users::SessionsController < Api::ApiController
  skip_before_action :verify_user_token, only: [:create]

  # POST /api/users/sign_in
  def create
    unless exists_create_required_params
      render_missing_required_params
      return
    end

    email = params[:session][:email]
    password = params[:session][:password]

    # Authentication
    @user = User.find_by_email(email)

    if @user
      if @user.valid_password? password
        @user.restore_authentication_token!
        # Render JSON in JBuilder.
        # See /app/views/api/users/sessions/create.json.jbuilder
        render status: :ok
      else
        render_invalid_email_or_password
      end
    else
      render_invalid_email_or_password
    end
  end

  # DELETE /api/users/sign_out
  def destroy
    user = User.find_by_authentication_token(params[:user_token])
    user.authentication_token = nil
    user.save!
    render status: :ok,
           json: { result: "ok", message: "Sign out succes" }
  end

  private

    def exists_create_required_params
      session_params = params[:session]
      return !( session_params[:email].nil? or session_params[:password].nil? )
    end

    def render_invalid_email_or_password
      render status: :unauthorized,
             json: { result: "error", message: "Invalid email or password" }
    end

end
