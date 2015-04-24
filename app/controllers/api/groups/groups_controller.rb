class Api::Groups::GroupsController < Api::ApiController

  # GET /api/groups
  def index
    user = User.find_by_authentication_token(params[:user_token])
    logger.debug "[API] User sender: #{user.attributes.inspect}"
    @groups = user.groups
    logger.debug "[API] Groups: #{@groups.inspect}"
    render status: :ok
  end

  # POST /api/groups
  def create
    user = User.find_by_authentication_token(params[:user_token])
    logger.debug "[API] User sender: #{user.attributes.inspect}"

    unless exists_create_group_required_params?
      render_missing_required_params
      return
    end

    group = Group.create(group_params)
    # Add user to group as manager
    group.add(user, as: 'manager')

    render status: :created,
           json: { result: "ok", message: "Create group success" }
  end

  private

    def exists_create_group_required_params?
      return false if params[:group].nil?
      group_params = params[:group]
      return !group_params[:name].nil?
    end

    def group_params
      logger.debug "[API] Group Params #{params}"
      params.require(:group).permit(:name, :description)
    end

end
