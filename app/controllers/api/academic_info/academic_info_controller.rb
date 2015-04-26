class Api::AcademicInfo::AcademicInfoController < Api::ApiController


  def edit

    logger.debug "[API] Edit AcademicInfo: #{params}"

    unless exists_required_params(params)
      render status: :bad_request,
             json: { result: "error", message: "Missing required parameters" }
      return
    end

    user = User.find_by_authentication_token(params[:user_token])

    academic_info = user.academic_info

    academic_info.carreer = params[:career]
    
    academic_info.save()

    render status: :ok,
            json: { result: "ok", message: "AcademicInfo has been updated" }

  end

    def exists_required_params(academic_info_params)
    logger.debug "[API] academic info, check params #{academic_info_params}"
    return !( academic_info_params[:career].nil?)
  end
end
