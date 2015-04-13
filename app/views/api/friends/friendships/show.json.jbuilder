json.key_format! camelize: :lower

json.result "ok"

json.message "Get friends success"

json.data do

  json.friends @friends do |friend|
    json.id         friend.id
    json.email      friend.email
    json.first_name friend.profile.first_name || ""
    json.last_name  friend.profile.last_name || ""
  end

  json.users_with_pending_friendship_request @pending_friendship_requests do |request|
    json.id         request.sender_user.id
    json.email      request.sender_user.email
    json.first_name request.sender_user.profile.first_name || ""
    json.last_name  request.sender_user.profile.last_name || ""
  end

  json.users_with_sent_friendship_request @sent_friendship_request do |request|
    json.id         request.receiver_user.id
    json.email      request.receiver_user.email
    json.first_name request.receiver_user.profile.first_name || ""
    json.last_name  request.receiver_user.profile.last_name || ""
  end

end
