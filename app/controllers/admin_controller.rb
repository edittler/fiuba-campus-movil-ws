class AdminController < ApplicationController
  layout "administrator"

  def index
    if not admin_signed_in?
      redirect_to new_admin_session_path
    end
  end

end
