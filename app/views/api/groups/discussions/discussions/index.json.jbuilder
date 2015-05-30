json.key_format! camelize: :lower

json.result "ok"

json.message "Get dicussions success"

json.data do
	json.groupDiscussions @discussions do |discussion|
	    json.id    				discussion.id
	    json.name        		discussion.subject
	    json.description 		""
	    json.author_id			discussion.user.id
      	json.author_first_name 	discussion.user.profile.first_name || ""
      	json.author_last_name  	discussion.user.profile.last_name || ""
	    json.creationDate		discussion.created_at
  	end
end