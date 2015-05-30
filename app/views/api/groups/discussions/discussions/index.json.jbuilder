json.key_format! camelize: :lower

json.result "ok"

json.message "Get dicussions success"

json.data do
	json.groupDiscussions @discussions do |discussion|
	    json.id    			discussion.id
	    json.name        	discussion.subject
	    json.description 	""
	    json.author			"TODO"
	    json.creationDate	discussion.created_at
  	end
end