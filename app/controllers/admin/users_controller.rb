class Admin::UsersController < ApplicationController
  layout "administrator"

  # This is Devise's authentication
  before_filter :authenticate_admin!

  def index
    @unapproved_users = User.where(approved: false)
    logger.debug "[API] Unapproved users: #{@unapproved_users}"
    @banned_users = User.where(banned: true)
    @active_users = User.where(approved: true, banned: false)
    @all_users = User.all
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
    #logger.debug "[ADMIN] Params: #{params}"
    @user = User.find(params[:id])
    logger.debug "[ADMIN] User to approve: #{@user.attributes.inspect}"
    @user.approved = true
    @user.save
    UserMailer.welcome(@user).deliver_now
    redirect_to admin_users_path
  end

  def ban
    @user = User.find(params[:id])
    logger.debug "[ADMIN] User to ban: #{@user.attributes.inspect}"
    @user.banned = true
    @user.save
    redirect_to admin_users_path
  end

  def unban
    @user = User.find(params[:id])
    logger.debug "[ADMIN] User to unban: #{@user.attributes.inspect}"
    @user.banned = false
    @user.save
    redirect_to admin_users_path
  end

  def user_params
    #params[:user] = params[:registration]
    logger.debug "[ADMIN] User Params: #{params}"
    params.require(:user).permit(:email, :password)
  end

end
