json.key_format! camelize: :lower

json.result "ok"

json.message "Discussion comments showed succesfully"

json.data do
	json.comentaries @comments do |comment|
	    json.id    			comment.id
	    json.message       	comment.text
	    json.image		 	"TODO"
	    json.author			"TODO"
	    json.creationDate	"TODO"
    end
end