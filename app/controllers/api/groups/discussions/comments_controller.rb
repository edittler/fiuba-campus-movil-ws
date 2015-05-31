class Api::Groups::Discussions::CommentsController < Api::ApiController

	def create_group_comment
		unless exists_create_comment_required_params?
      		render_missing_required_params
      		return
    	end

    	creatorUser = User.find_by_authentication_token(params[:user_token])
		discussion = Discussion.find_by(id: params[:discussion_id].to_i)
		if discussion.nil?
	  		render status: :error,
	           json: { result: "error", message: "Discussion does not exist" }
	        return
    	end	

		comment = Comment.create(text: params[:message])
		comment.user = creatorUser 	
    	discussion.comments << comment

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
