json.key_format! camelize: :lower

json.result "ok"

json.message "Sign in success"

json.data do

  json.user_id    @user.id
  json.user_token @user.authentication_token

end
