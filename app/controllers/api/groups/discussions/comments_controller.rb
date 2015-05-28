class Api::Groups::Discussions::CommentsController < Api::ApiController

	def create
		unless exists_create_comment_required_params?
      		render_missing_required_params
      		return
    	end

		discussion = Discussion.find_by(id: params[:discussion_id].to_i) 
		comment = Comment.create(text: params[:message]) 	
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
