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
    @discussion_author_full_name = "#{discussion.user.profile.first_name} #{discussion.user.profile.last_name}"
    subject = "Se ha publicado una nueva discusion en el grupo #{group.name}"
    mail(to: user.email, subject: subject)
  end

  def new_file_in_group(group, uploaded_datum, user)
    logger.debug "[USER MAILER] File Params: #{uploaded_datum.attributes.inspect}"
    @group = group
    @file = uploaded_datum
    @user = user
    @uploader_full_name = "#{@file.user.profile.first_name} #{@file.user.profile.last_name}"
    subject = "Se ha subido un nuevo archivo en el grupo #{group.name}"
    mail(to: user.email, subject: subject)
  end

end
