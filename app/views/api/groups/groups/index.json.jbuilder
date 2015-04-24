json.key_format! camelize: :lower

json.result "ok"

json.message "Get groups success"

json.data do

  json.groups @groups do |group|
    json.group_id    group.id
    json.name        group.name
    json.description group.description
  end

end