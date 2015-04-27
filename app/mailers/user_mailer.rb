class UserMailer < ApplicationMailer
  default from: "ezperez@fi.uba.ar"

  def welcome(user)
    logger.debug "[USER MAILER] User Params: #{user.attributes.inspect}"
    @user = user
    mail(to: @user.email, subject: 'Bienvenidos a FIUBA Campus Móvil')
  end

end
