# frozen_string_literal: true

require_relative "avocado/version"

module Avocado
  class Error < StandardError; end

  autoload :User, "avocado/user"
  autoload :UserEmail, "avocado/user_email"
  autoload :UserEmailAffirmation, "avocado/user_email_affirmation"
  autoload :UserEmailVerification, "avocado/user_email_verification"
  autoload :UserPassword, "avocado/user_password"
  autoload :UserPasswordRecovery, "avocado/user_password_recovery"
end
