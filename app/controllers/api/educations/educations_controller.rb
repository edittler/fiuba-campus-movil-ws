class Api::Educations::EducationsController < Api::ApiController

  def create

    logger.debug "[API] Create Education: #{params}"

    unless exists_required_params(params[:education])
      render status: :bad_request,
             json: { result: "error", message: "Missing required parameters" }
      return
    end

    user = User.find_by_authentication_token(params[:user_token])
    profile = user.profile

    education_params = params[:education]

    education = profile.educations.create()
    education.create_institute()
    education.create_date_interval()
    input_values_into_education(education,education_params)
    education.save()

    render status: :created,
            json: { result: "ok", message: "Education has been created" }
  end

  def edit

    logger.debug "[API] Edit Education: #{params}"

    education = Education.find_by( id:params[:id].to_i )
    unless  education
      render status: :conflict,
             json: { result: "error", message: "Education not found" }
      return
    end

    education_params = params[:education]
    input_values_into_education(education,education_params)
    education.save()

    render status: :edited,
            json: { result: "ok", message: "Education has been updated" }
  end

  def exists_required_params(education_params)
    logger.debug "[API] education Create, check params #{education_params}"
    return !( education_params[:institute].nil? or education_params[:date_interval][:init].nil? or education_params[:institute][:name].nil?)
  end

  def input_values_into_education(education,education_params)
    education.diploma = education_params[:diploma] unless education_params[:diploma].nil?
    education.institute.name = education_params[:institute][:name] unless education_params[:institute][:name].nil?
    education.date_interval.init = education_params[:date_interval][:init] unless education_params[:date_interval][:init].nil?
    education.date_interval.end = education_params[:date_interval][:end] unless education_params[:date_interval][:end].nil?
  end
end
