json.key_format! camelize: :lower

json.result "ok"

json.message "Basic search results"

json.data do

  json.users @users_found do |user|
    json.user_id    user[:id]
    json.email      user[:email]
    json.first_name user[:first_name] || ""
    json.last_name  user[:last_name] || ""
    json.friendship user[:friendship] || "noFriends"

    unless user[:friendship_request_id].nil?
      json.friendship_request_id user[:friendship_request_id]
    end

  end

end
