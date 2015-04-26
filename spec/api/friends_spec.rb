require 'rails_helper'

RSpec.describe "Tests de amistades.", type: :request do

  before(:each) do
    post "/api/users/sign_up",
         '{
              "email":     "treale@fiuba.com",
              "password":  "12345678",
              "padron":    "92140",
              "firstName": "Tom",
              "lastName":  "Reale"
         }',
         "CONTENT_TYPE" => 'application/json'

    post "/api/users/sign_up",
         '{
              "email":     "dramiro@fiuba.com",
              "password":  "12345678",
              "padron":    "92426",
              "firstName": "Diego",
              "lastName":  "Ramiro"
         }',
         "CONTENT_TYPE" => 'application/json'

    post "/api/users/sign_in",
         '{
              "email":     "treale@fiuba.com",
              "password":  "12345678"
         }',
         "CONTENT_TYPE" => 'application/json'

      login_json = JSON.parse(@response.body)
      @logged_user_id = login_json["data"]["userId"]
      @logged_user_token = login_json["data"]["userToken"]
  end

  describe "US225 Usuario puede ver a sus amigos." do

    it "UAT225.1 Usuario sin amigos" do
      get "/api/friends?userToken=#{@logged_user_token}"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(@response.body)
      assert_equal "ok", json["result"]
      assert json["data"]["friends"].empty?
    end

    it "UAT225.2 Usuario con amigos" do
      skip "Test medio complejo. En un futuro se realizará."
    end

  end

  describe "US243 Usuario puede enviar solicitudes de amistad a otros usuarios." do

    it "UAT243.1 Envía solicitud a usuario que no es amigo" do

      post "/api/users/sign_in",
           '{
                "email":     "dramiro@fiuba.com",
                "password":  "12345678"
           }',
           "CONTENT_TYPE" => 'application/json'

      login_json = JSON.parse(@response.body)
      user_token = login_json["data"]["userToken"]

      friendship_request_params = {
            userToken:     user_token,
            userToInviteId: @logged_user_id
      }
      post "/api/friends/send_friendship_request",
           friendship_request_params.to_json,
           "CONTENT_TYPE" => 'application/json'

      expect(response).to have_http_status(:ok)
      json = JSON.parse(@response.body)
      assert_equal "ok", json["result"]
    end

  end

end

