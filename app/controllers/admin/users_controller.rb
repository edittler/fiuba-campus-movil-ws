class Admin::UsersController < ApplicationController
  layout "administrator"

  # This is Devise's authentication
  before_filter :authenticate_admin!

  def index
    @users = User.all
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

  def user_params
    #params[:user] = params[:registration]
    logger.debug "[ADMIN] User Params: #{params}"
    params.require(:user).permit(:email, :password)
  end

end
