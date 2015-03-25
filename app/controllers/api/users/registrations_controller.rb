class Api::Users::RegistrationsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  # POST /api/users/sign_up
  def create
    logger.debug "[API] User Create #{params}"

    user = User.new(user_params)
    if user.save
      render status: :created, json: { sucess: true}
      return
    else
      warden.custom_failure!
      render status: :unprocessable_entity, :json => user.errors
    end
  end

  def user_params
    params[:user] = params[:registration]
    logger.debug "[API] User Params #{params}"
    params.require(:user).permit(:email, :password)
  end

end
