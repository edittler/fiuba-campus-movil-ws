class Api::ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :verify_json_request_format
  before_filter :underscore_key_json_params!
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

    def exists_user_token_param(params)
      return !params[:user_token].nil?
    end

    def render_missing_user_token_parameter
      render status: :not_found, json: { result: "error", message: "Missing userToken parameter" }
    end

    def render_invalid_user_token
      render status: :not_found, json: { result: "error", message: "Invalid userToken" }
    end

end