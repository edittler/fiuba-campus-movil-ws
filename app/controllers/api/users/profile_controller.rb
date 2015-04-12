class Api::Users::ProfileController < Api::ApiController

  def show
    @user = User.find(params[:id].to_i)
    logger.debug "[API] Show User: #{@user.attributes.inspect}"
  end

end
