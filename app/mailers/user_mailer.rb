class UserMailer < ApplicationMailer
  default from: "notifications@fiubacampusmovil.com.ar"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Bienvenidos a FIUBA Campus Móvil')
  end

end
