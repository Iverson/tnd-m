class ApplicationMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  
  default from: "noreplay@tnd.gymmer.ru"
  layout 'mailer'
end
