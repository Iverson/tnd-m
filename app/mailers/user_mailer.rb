class UserMailer < ApplicationMailer
  def performer_notify_email(user, tender)
    @user   = user
    @tender = tender
    mail(to: @user.email, subject: "Добавлен на проработку конкурс ##{@tender.id}")
  end
end
