class Api::ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :verify_json_request_format
  respond_to :json

  protected

    def verify_json_request_format
      if request.format != :json
        render status: :not_acceptable,
               json: { result: "error", message: "The request must be JSON." }
        return
      end
    end

end