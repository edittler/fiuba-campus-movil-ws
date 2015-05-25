class Api::Users::ProfileController < Api::ApiController

  def show
    request_user = User.find_by_authentication_token(params[:user_token])

    @user = User.find(params[:id])

    @friendship = "noFriends"
    if request_user.id == @user.id
      @friendship = "yourself"
      return
    end
    if request_user.friend? @user
      @friendship = "friends"
      return
    end
    if request_user.friendship_request_sent? @user
      @friendship = "friendshipRequestSent"
      return
    end
    if request_user.friendship_request_pending? @user
      @friendship = "pendingFriendshipRequest"
      return
    end
  end

  def update
    logger.debug "[API] Edit User: #{params}"

    updates = params[:data][:profile]

    user = User.find( params[:id].to_i )

    user.profile.first_name = updates[:first_name] unless updates[:first_name].nil?
    user.profile.last_name = updates[:last_name] unless updates[:last_name].nil?
    user.profile.biography = updates[:biography] unless updates[:biography].nil?
    user.profile.save

    user.profile.nationality.nationality = updates[:nationality] unless updates[:nationality].nil?
    user.profile.nationality.save

    user.profile.city.name = updates[:city] unless updates[:city].nil?
    user.profile.city.save

    user.profile.phone.number = updates[:phone] unless updates[:phone].nil?
    user.profile.phone.save

    user.profile.location.latitude = updates[:latitude]
    user.profile.location.longitude = updates[:longitude]
    user.profile.location.last_update_time = updates[:last_update_time]
    user.profile.location.save

    user.academic_info.padron = updates[:padron] unless updates[:padron].nil?
    user.academic_info.save

    render status: :created,
            json: { result: "ok", message: "Profile has been updated" }
  end

  def upload_picture

    unless exists_upload_picture_required_params
      render_missing_required_params
      return
    end

    user = User.find_by_authentication_token(params[:user_token])
    result = {
      result: "error",
      message: "An error has occurred. Try again with another image"
    }

    begin
      params[:image] = parse_image_data(params[:image]) if params[:image]
      user.profile.picture = params[:image]

      if user.profile.save
        result[:result] = "ok"
        result[:message] = "Upload profile image success"
        render status: :ok, json: result.to_json
        return
      end
    rescue Exception => e
      logger.error "#{e.message}"
    end

    render status: :internal_server_error, json: result.to_json
  ensure
    clean_tempfile
  end

  private

    def exists_upload_picture_required_params
      image_params = params[:image]
      return false if image_params.nil?
      return !( image_params[:filename].nil? or image_params[:content].nil? or image_params[:content_type].nil? )
    end

    def parse_image_data(image_data)
      @tempfile = Tempfile.new('item_image')
      @tempfile.binmode
      @tempfile.write Base64.decode64(image_data[:content])
      @tempfile.rewind

      uploaded_file = ActionDispatch::Http::UploadedFile.new(
        tempfile: @tempfile,
        filename: image_data[:filename]
      )

      uploaded_file.content_type = image_data[:content_type]
      uploaded_file
    end

    def clean_tempfile
      if @tempfile
        @tempfile.close
        @tempfile.unlink
      end
    end

end
