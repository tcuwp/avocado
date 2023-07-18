# frozen_string_literal: true

require_relative "avocado/version"
require_relative "avocado/engine"

module Avocado
  class Error < StandardError; end

  autoload :Authentication, "avocado/authentication"
  autoload :Current, "avocado/current"
  autoload :Mailer, "avocado/mailer"
  autoload :Session, "avocado/session"
  autoload :User, "avocado/user"
  autoload :UserEmail, "avocado/user_email"
  autoload :UserEmailAffirmation, "avocado/user_email_affirmation"
  autoload :UserEmailVerification, "avocado/user_email_verification"
  autoload :UserPassword, "avocado/user_password"
  autoload :UserPasswordReset, "avocado/user_password_reset"
end
