class Api::Users::ProfileController < Api::ApiController

  def show

    @profile = Profile.find_by!( user_id: params[:id].to_i )

    logger.debug "[API] Profile to show: #{@profile.attributes.inspect}"

    @nationality = Nationality.find_by!( profile_id: @profile.id )

    @city = City.find_by!( profile_id: @profile.id )

    @phone = Phone.find_by!( profile_id: @profile.id )

    @jobs = Job.find_by( profile_id: @profile.id )

    @academic_info = AcademicInfo.find_by!( user_id: params[:id].to_i )

    logger.debug "[API] Show academicInfo: #{@academic_info.attributes.inspect}"

    logger.debug "[API] Show User: #{@profile.attributes.inspect}"


  end

  def edit

    logger.debug "[API] Edit User: #{params}"
    @profile = Profile.find_by!( user_id: params[:id].to_i )

    profileUpdates = params[:data][:profile]

    @profile.first_name = profileUpdates[:first_name]
    @profile.last_name = profileUpdates[:last_name]
    @profile.biography = profileUpdates[:biography]
    @profile.save

    @nationality = Nationality.find_by!( profile_id: @profile.id )
    @nationality.nationality = profileUpdates[:nationality]
    @nationality.save

    @city = City.find_by!( profile_id: @profile.id )
    @city.name = profileUpdates[:city]
    @city.save

    @phone = Phone.find_by!( profile_id: @profile.id )
    @phone.number = profileUpdates[:phone]
    @phone.save

    @jobs = Job.find_by( profile_id: @profile.id )

    @academic_info = AcademicInfo.find_by!( user_id: params[:id].to_i )
    @academic_info.padron = profileUpdates[:padron]
    @academic_info.save
    
    render status: :created,
            json: { result: "ok", message: "Profile has been updated" }


  end

end
