module Admin::UsersHelper

  def user_full_name(user)
    "#{user.profile.first_name} #{user.profile.last_name}"
  end

  def user_padron(user)
    "#{user.academic_info.padron}"
  end

  def user_career(user)
    "#{user.academic_info.carreer}"
  end

  def approve_user_status(user)
    if user.approved
      "Si"
    else
      "No"
    end
  end

  def approve_user(user)
    if user.approved
      "Reenviar mail"
    else
      "Aprobar"
    end
  end

end
