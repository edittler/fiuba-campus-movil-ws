class Api::Groups::UploadedData::UploadedDataController < Api::ApiController

  # GET /api/groups/:id/uploaded_data
  def index
    group = Group.find_by(id: params[:id].to_i)
    if group.nil?
        render status: :error,
           json: { result: "error", message: "Group does not exist" }
        return
    end

    if group.uploaded_data.nil?
      render status: :ok,
             json: {result: "ok", message: "No uploaded data to show", data: { uploaded_data: [] } }
      return
    end

    @uploaded_data = group.uploaded_data
    render status: :ok
  end

  # GET /api/groups/:id/uploaded_data/:uploaded_datum_id
  #def show
  #  uploaded_datum = Uploaded_data.find_by(id: params[:uploaded_datum_id].to_i)
  #  if uploaded_datum.nil?
   #     render status: :error,
  #         json: { result: "error", message: "File does not exist" }
 #       return
 #   end
 #   @uploaded_datum = uploaded_datum
 #   render status: :ok
 # end

  # POST /api/groups/:id/uploaded_datum
  def create
    unless exists_create_file_required_params?
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

    if myUser.nil?
      render status: :error,
             json: { result: "error", message: "User does not exist" }
      return
    end

    if !myUser.in_group?(group)
      render status: :conflict,
             json: {result: "error", message: "User is not in the group"}
      return
    end

    uploaded_datum_params = params[:uploaded_datum]
    uploaded_datum = group.uploaded_data.create()
    input_values_into_uploaded_datum(uploaded_datum,uploaded_datum_params)
    uploaded_datum.user = myUser
    uploaded_datum.save()

    notify_new_uploaded_data(group, uploaded_datum)

    render status: :created,
           json: { result: "ok", message: "Uploaded datum success" }
  end  

  private

    def exists_create_file_required_params?
      if params[:uploaded_datum][:name].nil? or params[:uploaded_datum][:url].nil? #or params[:uploaded_datum][:type].nil?
        return false
      end
      return true
    end

    def input_values_into_uploaded_datum(uploaded_datum,uploaded_datum_params)
      uploaded_datum.name = uploaded_datum_params[:name]
      uploaded_datum.url = uploaded_datum_params[:url]
      #uploaded_datum.file_type = uploaded_datum_params[:type]
    end

    def notify_new_uploaded_data(group, uploaded_datum)
      members = User.in_group(group)
      members.each { |member|
        next if uploaded_datum.user.id == member.id
        UserMailer.new_file_in_group(group, uploaded_datum, member).deliver_now
      }
    end

end
