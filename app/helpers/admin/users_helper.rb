module Admin::UsersHelper

  def approve_user(user)
    if user.approved
      "Reenviar mail"
    else
      "Aprobar"
    end
  end

end
