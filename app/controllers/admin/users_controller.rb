class Admin::UsersController < ApplicationController
  layout "administrator"

  # This is Devise's authentication
  before_filter :authenticate_admin!

  def index
    if params[:approved] == "false"
      @users = User.find_all_by_approved(false)
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def approve
    logger.debug "[ADMIN] Params: #{params}"
    @user = User.find(params[:id])
    logger.debug "[ADMIN] User to approve: #{@user.attributes.inspect}"
    @user.approved = true
    @user.save
    UserMailer.welcome(@user).deliver_now
    redirect_to admin_users_path
  end

  def user_params
    #params[:user] = params[:registration]
    logger.debug "[ADMIN] User Params: #{params}"
    params.require(:user).permit(:email, :password)
  end

end
