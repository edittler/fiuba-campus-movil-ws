class Api::Users::RegistrationsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  #before_filter :configure_sign_up_params, only: [:create]

  # GET /api/users/sign_up
#  def new
#    super
#  end

  # POST /api/users/sign_up
  def create
    logger.info "[API] User Create #{params}"
    #super
    render json: {:status => "OK"}, status: :created # :bad_request
  end

  protected

  # Signs in a user on sign up.
  def sign_up(resource_name, resource)
    #sign_in(resource_name, resource)
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    render json: {:status => "OK"}, status: :created # :bad_request
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    render json: {:status => "Inactive User"}, status: :unauthorized # :bad_request
  end

end
