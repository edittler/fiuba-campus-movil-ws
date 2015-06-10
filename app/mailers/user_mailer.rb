class UserMailer < ApplicationMailer
  default from: "fiubacampusmovil@gmail.com"

  def welcome(user)
    logger.debug "[USER MAILER] User Params: #{user.attributes.inspect}"
    @user = user
    mail(to: @user.email, subject: 'Bienvenidos a FIUBA Campus Movil')
  end

  def arrive_friendship_request(sender_user, receiver_user)
    logger.debug "[USER MAILER] Sender user Params: #{sender_user.attributes.inspect}"
    logger.debug "[USER MAILER] Receiver user Params: #{receiver_user.attributes.inspect}"
    @sender_user = sender_user
    @receiver_user = receiver_user
    @sender_user_full_name = "#{sender_user.profile.first_name} #{sender_user.profile.last_name}"
    subject = "Recibiste una solicitud de amistad de #{@sender_user_full_name}"
    mail(to: @receiver_user.email, subject: subject)
  end

  def acept_friendship_request(sender_user, receiver_user)
    logger.debug "[USER MAILER] Sender user Params: #{sender_user.attributes.inspect}"
    logger.debug "[USER MAILER] Receiver user Params: #{receiver_user.attributes.inspect}"
    @sender_user = sender_user
    @receiver_user = receiver_user
    @sender_user_full_name = "#{sender_user.profile.first_name} #{sender_user.profile.last_name}"
    subject = "Recibiste una solicitud de amistad de #{@sender_user_full_name}"
    mail(to: @receiver_user.email, subject: subject)
  end

end
