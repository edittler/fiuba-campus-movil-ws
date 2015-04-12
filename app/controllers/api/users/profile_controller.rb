class Api::Users::ProfileController < Api::ApiController

  def show
    
    @user = User.find(params[:id].to_i)
    @nationality = Nationality.find( @user.profile.nationality_id )   if  !@user.profile.nationality_id.nil?
    @city = City.find( @user.profile.city_id )                        if  !@user.profile.city_id.nil?

    logger.debug "[API] Show User: #{@user.attributes.inspect}"
  end

end
