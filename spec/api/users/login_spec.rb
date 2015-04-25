require 'rails_helper'

RSpec.describe "US224 Inicio de sesión de usuarios.", type: :request do

  describe "Usuarios sin registro previo." do

    it "UAT224.3 Alumno sin registro no puede ingresar" do
      post "/api/users/sign_in",
          '{
                "email":     "treale@fiuba.com",
                "password":  "12345678"
           }',
           "CONTENT_TYPE" => 'application/json'

      expect(response).to have_http_status(:unauthorized)
      json = JSON.parse(@response.body)
      assert_equal "error", json["result"]
    end

  end

  describe "Usuarios con resgistro previo.", type: :request do

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
    end

    it "UAT224.1 Inicio de sesión correcto" do
      post "/api/users/sign_in",
          '{
                "email":     "treale@fiuba.com",
                "password":  "12345678"
           }',
           "CONTENT_TYPE" => 'application/json'

      expect(response).to have_http_status(:ok)
      json = JSON.parse(@response.body)
      assert_equal "ok", json["result"]
      assert json["data"].include?("userId")
      assert json["data"].include?("userToken")
    end

    it "UAT224.2 Inicio de sesión con mail inválido" do
      post "/api/users/sign_in",
          '{
                "email":     "trealeatfiubadotcom",
                "password":  "12345678"
           }',
           "CONTENT_TYPE" => 'application/json'

      expect(response).to have_http_status(:unauthorized)
      json = JSON.parse(@response.body)
      assert_equal "error", json["result"]
    end

    it "UAT224.4 Inicio de sesión con contraseña incorrecta" do
      post "/api/users/sign_in",
          '{
                "email":     "treale@fiuba.com",
                "password":  "1234567"
           }',
           "CONTENT_TYPE" => 'application/json'

      expect(response).to have_http_status(:unauthorized)
      json = JSON.parse(@response.body)
      assert_equal "error", json["result"]
    end

  end

end

