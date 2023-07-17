class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@host.example"
  layout "mailer"
end
