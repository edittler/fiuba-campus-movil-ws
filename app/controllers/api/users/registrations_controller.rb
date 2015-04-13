class Api::Users::RegistrationsController < Api::ApiController
  skip_before_action :verify_user_token, only: [:create]

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

    # Create user
    user = User.new( user_params() )
    if user.save
      #user.create_profile(:first_name => "tom" , :last_name => "rea", :biography => "aaaaaaaKBbiography")
      #profile = Profile.find_by!( user_id: user.id )
      #profile.create_city(:name => "bs as")
      #profile.create_nationality( :nationality => "argentino")
      #profile.create_phone( :number => "666666")
      #profile.create_location()
      user.create_profile( profile_params() )
      profile = Profile.find_by!( user_id: user.id )
      profile.create_city()
      profile.create_nationality( )
      profile.create_phone()
      profile.create_location()
      user.create_academic_info( academic_info_params() )
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
      return !( params[:email].nil? or params[:password].nil? or params[:padron].nil? or params[:first_name].nil? or params[:last_name].nil? )
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
