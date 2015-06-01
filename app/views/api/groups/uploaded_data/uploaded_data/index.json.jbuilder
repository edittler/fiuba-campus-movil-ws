json.key_format! camelize: :lower

json.result "ok"

json.message "Get uploaded data"

json.data do
    json.group_uploaded_data @uploaded_data do |datum|
        json.id                    datum.id
        json.name                  datum.name
        json.url                   datum.url
        json.file_type             datum.file_type
        json.author_id             datum.user.id
        json.author_first_name     datum.user.profile.first_name
        json.author_last_name      datum.user.profile.last_name
        json.creation_date         datum.created_at
    end
end