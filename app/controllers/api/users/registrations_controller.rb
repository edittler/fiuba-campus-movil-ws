class Api::Users::RegistrationsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  # POST api/users/sign_up
  def create
    logger.info "[API] User Create #{params}"
    response = { :valid_data => true, :font_family => "Arial" }
    render json: {:status => "OK"}, status: :created # :bad_request
  end

end
