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

    group = Group.create(groups_params)
    # Add user to group as manager
    group.add(user, as: 'manager')

    render status: :created,
           json: { result: "ok", message: "Succes create groups" }
  end

  private

    def groups_params
      logger.debug "[API] Group Params #{params}"
      params.require(:group).permit(:name, :description)
    end

end
