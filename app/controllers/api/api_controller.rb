class Api::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :verify_json_request_format
  before_action :underscore_key_json_params!
  before_action :verify_user_token
  respond_to :json

  protected

    def verify_json_request_format
      if request.format != :json
        render status: :not_acceptable,
               json: { result: "error", message: "The request must be JSON" }
        return
      end
    end

    def underscore_key_json_params!(val = params)
      case val
      when Array
        val.map {|v| underscore_key_json_params! v }
      when Hash
        val.keys.each do |k, v = val[k]|
          val.delete k
          val[k.underscore] = underscore_key_json_params!(v)
        end
        val
      else
        val
      end
    end

    def verify_user_token
      if params[:user_token].nil?
        render_missing_user_token_parameter
        return
      end

      user = User.find_by_authentication_token(params[:user_token])
      if user.nil?
        render_invalid_user_token
        return
      end
    end

    def render_missing_user_token_parameter
      render status: :bad_request, json: { result: "error", message: "Missing userToken parameter" }
    end

    def render_invalid_user_token
      render status: :not_found, json: { result: "error", message: "Invalid userToken" }
    end

end