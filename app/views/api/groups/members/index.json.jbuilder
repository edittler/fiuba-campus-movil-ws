json.key_format! camelize: :lower

json.result "ok"

json.message "Get group members success"

json.data do

  json.group do
    json.id          @group.id
    json.name        @group.name
    json.description @group.description

    json.members @group_members do |member|
      json.user_id    member.id
      json.first_name member.profile.first_name || ""
      json.last_name  member.profile.last_name || ""
    end
  end

end