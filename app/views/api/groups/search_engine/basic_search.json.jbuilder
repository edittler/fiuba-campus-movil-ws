json.key_format! camelize: :lower

json.result "ok"

json.message "Group basic search results"

json.data do

  json.groups_by_name @groups_by_name do |group|
    json.group_id    group[:id]
    json.name        group[:name]
    json.description group[:description]
    json.is_member   group[:is_member]
  end

end
