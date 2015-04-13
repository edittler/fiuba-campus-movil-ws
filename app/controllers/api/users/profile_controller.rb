class Api::Users::ProfileController < Api::ApiController

  def show

    @profile = Profile.find_by!( user_id: params[:id].to_i )

    @nationality = Nationality.find_by!( profile_id: @profile.id )

    @city = City.find_by!( profile_id: @profile.id )

    @phone = Phone.find_by!( profile_id: @profile.id )

    @jobs = Job.find_by( profile_id: @profile.id )

    logger.debug "[API] Show User: #{@profile.attributes.inspect}"
  end

  def edit

    @profile = Profile.find_by!( user_id: params[:id].to_i )

    profileUpdates = params[:data][:profile]

    @profile.first_name = profileUpdates[:firstName]
    @profile.last_name = profileUpdates[:lastName]
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
    render status: :created,
            json: { result: "ok", message: "Profile has been updated" }


  end

end
