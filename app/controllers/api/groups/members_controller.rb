class Api::Groups::MembersController < Api::ApiController

  # GET /api/groups/:id/members
  def index
    @group = Group.find_by(id: params[:id].to_i)

    if @group.nil?
      render status: :not_found,
             json: {result: "error", message: "The group does not exist"}
      return
    end

    @group_members = User.in_group(@group)
    logger.debug "[API] Group Members: #{@group_members.inspect}"

    render status: :ok
  end

  # POST /api/groups/:id/join
  def join
    user = User.find_by_authentication_token(params[:user_token])

    group = Group.find_by(id: params[:id].to_i)

    if group.nil?
      render status: :not_found,
             json: {result: "error", message: "The group does not exist"}
      return
    end

    if user.in_group?(group)
      render status: :conflict,
             json: {result: "error", message: "Already a member of the group"}
      return
    end

    group.add user

    render status: :ok,
             json: {result: "ok", message: "It has joined the group correctly"}
  end

end
