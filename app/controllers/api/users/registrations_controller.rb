class Api::Users::RegistrationsController < Api::ApiController

  # POST /api/users/sign_up
  def create
    # Check correct params
    unless exists_required_params(params[:registration])
      render status: :bad_request,
             json: { result: "error", message: "Missing required parameters" }
      return
    end

    # Check exist user e-mail
    if User.find_by_email(params[:registration][:email])
      render status: :conflict,
             json: { result: "error", message: "User already exist" }
      return
    end

    profile = Profile.create(name: "pepito")

    # Create user
    other_params = user_params
    other_params[:profile_id] = profile.id
    user = User.new( other_params )
    if user.save
      render status: :created,
            json: { result: "ok", message: "User has been created" }
      return
    else
      warden.custom_failure!
      render status: :bad_request,
             json: { result: "error", message: "An error has occurred", errors: user.errors }
    end
  end

  private

    def exists_required_params(registration_params)
      logger.debug "[API] User Create, check params #{registration_params}"
      return ( !params[:email].nil? and !params[:password].nil? )
    end

    def user_params
      logger.debug "[API] User Params #{params}"
      params.require(:registration).permit(:email, :password)
    end

    def profile_params
      logger.debug "[API] Profile Params #{params}"
      params.require(:registration).permit(:email, :password)
    end

end
