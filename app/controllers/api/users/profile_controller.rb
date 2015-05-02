class Api::Users::ProfileController < Api::ApiController

  def show
    request_user = User.find_by_authentication_token(params[:user_token])

    @user = User.find(params[:id])

    @friendship = "noFriends"
    if request_user.id == @user.id
      @friendship = "yourself"
      return
    end
    if request_user.friend? @user
      @friendship = "friends"
      return
    end
    if request_user.friendship_request_sent? @user
      @friendship = "friendshipRequestSent"
      return
    end
    if request_user.friendship_request_pending? @user
      @friendship = "pendingFriendshipRequest"
      return
    end
  end

  def edit

    logger.debug "[API] Edit User: #{params}"
    @profile = Profile.find_by( user_id: params[:id].to_i )

    profileUpdates = params[:data][:profile]

    @profile.first_name = profileUpdates[:first_name] unless profileUpdates[:first_name].nil?
    @profile.last_name = profileUpdates[:last_name] unless profileUpdates[:last_name].nil?
    @profile.biography = profileUpdates[:biography] unless profileUpdates[:biography].nil?
    @profile.save

    @nationality = Nationality.find_by( profile_id: @profile.id )
    @nationality.nationality = profileUpdates[:nationality] unless profileUpdates[:nationality].nil?
    @nationality.save

    @city = City.find_by( profile_id: @profile.id )
    @city.name = profileUpdates[:city] unless profileUpdates[:city].nil?
    @city.save

    @phone = Phone.find_by( profile_id: @profile.id )
    @phone.number = profileUpdates[:phone] unless profileUpdates[:phone].nil?
    @phone.save

    @academic_info = AcademicInfo.find_by( user_id: params[:id].to_i )
    @academic_info.padron = profileUpdates[:padron] unless profileUpdates[:padron].nil?
    @academic_info.save
    
    render status: :created,
            json: { result: "ok", message: "Profile has been updated" }
  end

end
