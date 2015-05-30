json.key_format! camelize: :lower

json.result "ok"

json.message "Discussion comments showed succesfully"

json.data do
	json.comentaries @comments do |comment|
	    json.id    				comment.id
	    json.message       		comment.text
	    json.image		 		comment.user.profile.picture.url(:small) || ""
	    json.author_id			comment.user.id
      	json.author_first_name 	comment.user.profile.first_name || ""
      	json.author_last_name  	comment.user.profile.last_name || ""
	    json.creationDate		comment.created_at
    end
end