class UserMailer < ApplicationMailer
  default from: "fiubacampusmovil@gmail.com"

  def welcome(user)
    logger.debug "[USER MAILER] User Params: #{user.attributes.inspect}"
    @user = user
    mail(to: @user.email, subject: 'Bienvenidos a FIUBA Campus Movil')
  end

end
