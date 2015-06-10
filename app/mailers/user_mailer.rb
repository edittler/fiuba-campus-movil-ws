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
    subject = "#{@sender_user_full_name} ha aceptado tu solicitud de amistad"
    mail(to: @receiver_user.email, subject: subject)
  end

  def new_discussion_in_group(group, discussion, user)
    logger.debug "[USER MAILER] Discussion Params: #{discussion.attributes.inspect}"
    @group = group
    @discussion = discussion
    @user = user
    @user_full_name = "#{user.profile.first_name} #{user.profile.last_name}"
    subject = "Se ha publicado una nueva discusion en el grupo #{group.name}"
    mail(to: user.email, subject: subject)
  end

end
