json.key_format! camelize: :lower

json.result "ok"

json.message "Get user profile sucess"

json.data do

  json.profile do
    json.first_name  @user.profile.first_name || ""
    json.last_name   @user.profile.last_name || ""
    json.picture     @user.profile.picture.url(:thumb) || ""
    json.biography   @user.profile.biography || ""
    json.nationality @user.profile.nationality.nationality || ""
    json.city        @user.profile.city.name || ""
    json.phone       @user.profile.phone.number || ""
    json.padron      @user.academic_info.padron || ""
    json.career      @user.academic_info.carreer || ""
    json.friendship  @friendship

    json.academic_info do
      json.padron @user.academic_info.padron || ""
      json.career @user.academic_info.carreer || ""
    end

    json.location do
      json.latitude @user.profile.location.latitude || ""
      json.longitude @user.profile.location.longitude || ""
    end

    json.jobs @user.profile.jobs do |job|
      json.id       job.try(:id) || ""
      json.company  job.try(:company) || ""
      json.position job.try(:position) || ""
      json.date_interval do
        json.init job.try(:date_interval).try(:init) || ""
        json.end  job.try(:date_interval).try(:end) || ""
      end
    end

    json.educations @user.profile.educations do |education|
      json.id      education.try(:id) || ""
      json.diploma education.try(:diploma) || ""

      json.institute do
        json.id   education.try(:institute).try(:id) || ""
        json.name education.try(:institute).try(:name) || ""
      end

      json.date_interval do
        json.init education.try(:date_interval).try(:init) || ""
        json.end  education.try(:date_interval).try(:end) || ""
      end
    end

  end

end
