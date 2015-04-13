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

    @profile.first_name = params[:first_name]
    @profile.last_name = params[:last_name]
    @profile.biography = params[:biography]
    @profile.save

    @nationality = Nationality.find_by!( profile_id: @profile.id )
    @nationality.nationality = params[:nationality]
    @nationality.save

    @city = City.find_by!( profile_id: @profile.id )
    @city.name = params[:city]
    @city.save

    @phone = Phone.find_by!( profile_id: @profile.id )
    @phone.number = params[:phone]
    @phone.save

    @jobs = Job.find_by( profile_id: @profile.id )
    render status: :created,
            json: { result: "ok", message: "Profile has been updated" }


  end

end
