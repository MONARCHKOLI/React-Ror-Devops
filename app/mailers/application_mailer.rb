# frozen_string_literal: true

# ApplicationMailer is the base mailer class for sending emails in the application.
class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@example.com'
  layout 'mailer'
end
