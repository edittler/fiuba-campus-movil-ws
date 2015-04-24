class Api::Groups::GroupsController < Api::ApiController

  def index
    user = User.find_by_authentication_token(params[:user_token])
    logger.debug "[API] User sender: #{user.attributes.inspect}"
    @groups = user.groups
    logger.debug "[API] Groups: #{@groups.inspect}"
    render status: :ok
  end

  def create
    render status: :created,
           json: { result: "ok", message: "Succes create groups" }
  end

end
