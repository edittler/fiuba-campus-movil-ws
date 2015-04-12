json.key_format! camelize: :lower

json.result "ok"

json.message "Get user profile sucess"

json.data do

  json.profile do

    json.first_name  @user.profile.first_name || ""
    json.last_name  @user.profile.last_name || ""

    json.location do
      json.latitude @user.profile.try(:location).try(:latitude) || ""
      json.longitude @user.profile.try(:location).try(:longitude) || ""
  end

    json.biography  @user.profile.biography || ""
    json.nationality  @nationality || ""
    json.city  @city || ""

    json.phone do
      json.type    @user.profile.try(:phone).try(:type) || ""
      json.phone  @user.profile.try(:phone).try(:phone) || ""
    end
  end

end
