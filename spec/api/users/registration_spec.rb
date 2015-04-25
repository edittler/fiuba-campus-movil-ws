require 'rails_helper'

RSpec.describe "Registration US249", type: :request do

  it "UAT249.1 alumno se registra correctamente" do
    post "/api/users/sign_up",
        '{
              "email":     "treale@fiuba.com",
              "password":  "12345678",
              "padron":    "92140",
              "firstName": "Tom",
              "lastName":  "Reale"
         }',
         "CONTENT_TYPE" => 'application/json'

    expect(response).to have_http_status(:created)
    json = JSON.parse(@response.body)
    assert_equal "ok", json["result"]
  end

  it "UAT249.2 alumno se registra ingresando mail invalido" do
    post "/api/users/sign_up",
        '{
              "email":     "mimailpuntocom",
              "password":  "12345678",
              "padron":    "92140",
              "firstName": "Tom",
              "lastName":  "Reale"
         }',
         "CONTENT_TYPE" => 'application/json'

    expect(response).to have_http_status(:bad_request)
    json = JSON.parse(@response.body)
    assert_equal "error", json["result"]
  end

  it "UAT249.3 alumno se registra ingresando mail ya registrado" do
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
              "email":     "treale@fiuba.com",
              "password":  "12345678",
              "padron":    "92140",
              "firstName": "Tom",
              "lastName":  "Reale"
         }',
         "CONTENT_TYPE" => 'application/json'

    expect(response).to have_http_status(:conflict)
    json = JSON.parse(@response.body)
    assert_equal "error", json["result"]
  end

  it "UAT249.4 alumno se registra ingresando contraseña con longitud menor a 8 caracteres" do
    post "/api/users/sign_up",
        '{
              "email":     "treale@fiuba.com",
              "password":  "1234567",
              "padron":    "92140",
              "firstName": "Tom",
              "lastName":  "Reale"
         }',
         "CONTENT_TYPE" => 'application/json'

    expect(response).to have_http_status(:bad_request)
    json = JSON.parse(@response.body)
    assert_equal "error", json["result"]
  end

end