module Admin::UsersHelper

  def user_full_name(user)
    "#{user.profile.first_name} #{user.profile.last_name}"
  end

  def user_padron(user)
    "#{user.academic_info.padron}"
  end

  def approve_user_status(user)
    if user.approved
      "Si"
    else
      "No"
    end
  end

  def banned_user_status(user)
    if user.banned
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

  def ban_user(user)
    if user.banned
      "Activar"
    else
      "Suspender"
    end
  end

  def ban_unban_user_path(user)
    if user.banned
      admin_user_unban_path(user)
    else
      admin_user_ban_path(user)
    end
  end

end
