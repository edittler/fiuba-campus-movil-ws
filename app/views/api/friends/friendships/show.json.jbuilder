json.key_format! camelize: :lower

json.result "ok"

json.message "Get friends success"

json.data do

  json.friends @friends do |friend|
    json.id      friend.id
    json.email   friend.email
  end

end
