class Api::Groups::Discussions::DiscussionsController < Api::ApiController

  # GET /api/groups/:id/discussions
  def index
  	group = Group.find_by(id: params[:id].to_i)
  	if group.nil?
  		render status: :error,
           json: { result: "error", message: "Group does not exist" }
        return
    end	
  	if group.forum.nil?
  		render status: :ok,
             json: {result: "ok", message: "No discussions to show", data: { groupDiscussions: [] } }
      return
    end

  	@discussions = group.forum.discussions
    render status: :ok
  end

  # GET /api/groups/:id/discussions/:discussion_id
  def show
  	discussion = Discussion.find_by(id: params[:discussion_id].to_i)    	
  	if discussion.nil?
  		render status: :error,
           json: { result: "error", message: "Discussion does not exist" }
        return
    end	

    @comments = discussion.comments
    render status: :ok
  end

  # POST /api/groups/:id/discussions
  def create   

    unless exists_create_discussion_required_params?
      render_missing_required_params
      return
    end

    myUser = User.find_by_authentication_token(params[:user_token])
    group = Group.find_by(id: params[:id].to_i)
    if group.nil?
  		render status: :error,
           json: { result: "error", message: "Group does not exist" }
        return
    end

  	if !myUser.in_group?(group)
      render status: :conflict,
             json: {result: "error", message: "User is not in the group"}
      return
    end

    if group.forum.nil?
  		group.forum = Forum.create(title: "", description: "")
    end
  	discussion = Discussion.create(subject: params[:subject])
  	discussion.user = myUser
  	group.forum.discussions << discussion

    render status: :created,
           json: { result: "ok", message: "Create discussion success" }
  end  

  private

    def exists_create_discussion_required_params?
      if params[:subject].nil?
      	return false
      end
      return true
    end

end
