require 'rails_helper'

RSpec.describe Api::Users::RegistrationsController, type: :controller do

  describe "Registro de un usuario (POST api/users/sign_up)" do

#    it "Usuario creado existosamente (HTTP 201 Created)" do
#      params = { registration: { email: "user@company.com", password: "12345678" } }
#      post :create, params.to_json, format: :json
#      expect(response).to have_http_status(:created)
#      expect(response.body).to eq({ result: "error", message: "Missing required parameters" }.to_json)
#    end

    it "Parametros faltantes (HTTP 400 Bad Request)" do
      params = { email: "user@company.com" }
      post :create, params.to_json, format: :json
      expect(response).to have_http_status(:bad_request)
      expect(response.body).to eq({ result: "error", message: "Missing required parameters" }.to_json)
    end

  end

end
