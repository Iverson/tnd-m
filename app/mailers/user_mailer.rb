class UserMailer < ApplicationMailer
  def performer_notify_email(user, milestone)
    @user   = user
    @tender = milestone.tender
    @milestone = milestone
    mail(to: @user.email, subject: "Добавлен на проработку конкурс ##{@tender.id}")
  end
end
