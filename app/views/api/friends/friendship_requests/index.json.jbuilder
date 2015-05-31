json.key_format! camelize: :lower

json.result "ok"

json.message "Get pending friendship requests success"

json.data do

  json.pending_friendship_requests @pending_friendship_requests do |request|
    json.friendship_request_id request.id
    json.user_id               request.sender_user.id
    json.email                 request.sender_user.email
    json.first_name            request.sender_user.profile.first_name || ""
    json.last_name             request.sender_user.profile.last_name || ""
    json.picture               request.sender_user.profile.picture_url
  end

end