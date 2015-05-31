class Api::Users::Wall::CommentsController < Api::ApiController

	def index
    	user = User.find_by_authentication_token(params[:user_token])
		wall = user.wall
		if user.nil?
			render status: :error,
	       json: { result: "error", message: "User does not exist" }
	    	return
		end	
		if user.wall.comments.nil?
			render status: :ok,
	         json: {result: "ok", message: "No comments to show", data: { wallComments: [] } }
	  		return
		end
		@comments = user.wall.comments
		render status: :ok
	end

	def create_wall_comment
		unless exists_create_comment_required_params?
      		render_missing_required_params
      		return
    	end

    	creatorUser = User.find_by_authentication_token(params[:user_token])
		wall = creatorUser.wall
		if creatorUser.nil?
	  		render status: :error,
	           json: { result: "error", message: "User does not exist" }
	        return
    	end	

    	if wall.nil?
	  		render status: :error,
	           json: { result: "error", message: "Wall does not exist" }
	        return
    	end

		comment = Comment.create(text: params[:message])
		comment.user = creatorUser 	
    	wall.comments << comment

		render status: :created,
           json: { result: "ok", message: "Create comment success" }
	end

private
	def exists_create_comment_required_params?
      if params[:message].nil?
      	return false
      end
      return true
    end
end
