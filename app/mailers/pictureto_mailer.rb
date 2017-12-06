class PicturetoMailer < ApplicationMailer
 layout "mailer"

  def pictureto_mail(picture)
    @picturetomail = picture
    mail(to: @picturetomail.email, subject: 'ブログが作成できました。')
  end
end
