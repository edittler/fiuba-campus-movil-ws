class Api::Jobs::JobController < Api::ApiController

  def create

    logger.debug "[API] Create Job: #{params}"

    unless exists_required_params(params[:job])
      render status: :bad_request,
             json: { result: "error", message: "Missing required parameters" }
      return
    end

    user = User.find_by_authentication_token(params[:user_token])
    profile = user.profile

    job_params = params[:job]

    job = profile.jobs.create()
    job.create_date_interval()
    input_values_into_job(job,job_params)
    job.save()

    render status: :created,
            json: { result: "ok", message: "Job has been created" }
  end

  def edit

    logger.debug "[API] Edit Job: #{params}"

    job = Job.find_by( id:params[:id].to_i )
    unless  job
      render status: :conflict,
             json: { result: "error", message: "Job not found" }
      return
    end

    job_params = params[:job]
    input_values_into_job(job,job_params)
    job.save()

    render status: :ok,
            json: { result: "ok", message: "Job has been updated" }
  end

  def destroy

    logger.debug "[API] Destroy Job: #{params}"

    job = Job.find_by( id:params[:id].to_i )
    unless  job
      render status: :conflict,
             json: { result: "error", message: "Job not found" }
      return
    end

    job.destroy()

    render status: :ok,
            json: { result: "ok", message: "Job has been deleted" }
  end

  def exists_required_params(job_params)
    logger.debug "[API] Job Create, check params #{job_params}"
    return !( job_params[:position].nil? or job_params[:date_interval][:init].nil? )
  end

  def input_values_into_job(job,job_params)
    job.company = job_params[:company] unless job_params[:company].nil?
    job.position = job_params[:position] unless job_params[:position].nil?
    job.date_interval.init = job_params[:date_interval][:init] unless job_params[:date_interval][:init].nil?
    job.date_interval.end = job_params[:date_interval][:end] unless job_params[:date_interval][:end].nil?
  end
end
