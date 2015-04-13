json.key_format! camelize: :lower

json.result "ok"

json.message "Get user profile sucess"

json.data do

  json.profile do

    json.firstn  @profile.firstn || ""

    json.lastName  @profile.lastn || ""

    json.biography  @profile.biography || ""

    json.location do
      json.latitude @profile.try(:location).try(:latitude) || ""
      json.longitude @profile.try(:location).try(:longitude) || ""
    end

    json.nationality  @nationality.nationality || ""

    json.city  @city.name || ""

    json.phone @phone.number || ""

    json.jobs(@jobs) do |json, job|
      json.job_id  job.try(:id) || ""
      json.company  job.try(:company) || ""
      json.position  job.try(:position) || ""
      json.init  job.try(:date_interval).try(:init) || ""
      json.end  job.try(:date_interval).try(:end) || ""
    end

  end

end