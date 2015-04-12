json.key_format! camelize: :lower

json.result "ok"

json.message "Get user profile sucess"

json.data do

  json.user do
    json.id      @user.id
    json.email   @user.email
  end

end
