class Api::Groups::MembersController < Api::ApiController

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

end
