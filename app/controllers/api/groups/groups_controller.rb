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

  def upload_picture

    unless exists_upload_picture_required_params
      render_missing_required_params
      return
    end

    puts "PUERCO1"

    myUser = User.find_by_authentication_token(params[:user_token])
    group = Group.find_by(id: params[:id].to_i)
    if group.nil?
      render status: :error,
           json: { result: "error", message: "Group does not exist" }
        return
    end

    puts "PUERCO2"

    if !myUser.in_group?(group)
      render status: :conflict,
             json: {result: "error", message: "User is not in the group"}
      return
    end

    puts "PUERCO3"

    begin
      params[:image] = parse_image_data(params[:image]) if params[:image]
      group.picture = params[:image]

      puts "PUERCO4"
      
      result = {
        result: "error",
        message: "An error has occurred. Try again with another image"
      }
      if group.save
        result[:result] = "ok"
        result[:message] = "Upload group profile image success"
        render status: :ok, json: result.to_json
        return
      end
    puts "PUERCO5"
    rescue Exception => e
      logger.error "#{e.message}"
    end

    puts "PUERCO6"

    render status: :internal_server_error, json: result.to_json
    puts "PUERCO7"
  ensure
    clean_tempfile
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

    def exists_upload_picture_required_params
      puts "PUERCO11"
      image_params = params[:image]
      return false if image_params.nil?
      puts "PUERCO12"
      return !( image_params[:filename].nil? or image_params[:content].nil? or image_params[:content_type].nil? )
    end

    def parse_image_data(image_data)
      puts "PUERCO21"
      @tempfile = Tempfile.new('item_image')
      @tempfile.binmode
      @tempfile.write Base64.decode64(image_data[:content])
      @tempfile.rewind
      puts "PUERCO22"

      uploaded_file = ActionDispatch::Http::UploadedFile.new(
        tempfile: @tempfile,
        filename: image_data[:filename]
      )
      puts "PUERCO23"
      uploaded_file.content_type = image_data[:content_type]
      uploaded_file
      puts "PUERCO24"
    end

    def clean_tempfile
      if @tempfile
        @tempfile.close
        @tempfile.unlink
      end
    end

end
