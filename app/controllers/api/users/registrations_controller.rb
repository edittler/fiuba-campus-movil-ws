class Api::Users::RegistrationsController < Api::ApiController
  skip_before_action :verify_user_token, only: [:create]

  # POST /api/users/sign_up
  def create
    # Check correct params
    unless exists_required_params(params[:registration])
      render_missing_required_params
      return
    end

    # Check exist user e-mail
    if User.find_by_email(params[:registration][:email])
      render status: :conflict,
             json: { result: "error", message: "User already exist" }
      return
    end

    # Create user
    user = User.new(user_params)
    if user.save
      user.create_profile(profile_params)
      user.profile.create_city
      user.profile.create_nationality
      user.profile.create_phone
      user.profile.create_location
      user.create_academic_info(academic_info_params)
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
      return !( registration_params[:email].nil? or registration_params[:password].nil? or registration_params[:padron].nil? or registration_params[:first_name].nil? or registration_params[:last_name].nil? )
    end

    def user_params
      logger.debug "[API] User Params #{params}"
      params.require(:registration).permit(:email, :password)
    end

   def profile_params
      logger.debug "[API] Profile Params #{params}"
      params.require(:registration).permit(:first_name, :last_name)
    end

   def academic_info_params
      logger.debug "[API] Academic_info Params #{params}"
      params.require(:registration).permit(:padron)
    end

end
