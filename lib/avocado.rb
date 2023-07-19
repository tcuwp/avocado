# frozen_string_literal: true

require_relative "avocado/engine"

module Avocado
  class Error < StandardError; end

  autoload :Authentication, "avocado/authentication"
  autoload :Current, "avocado/current"
  autoload :Mailer, "avocado/mailer"
  autoload :Session, "avocado/session"
  autoload :User, "avocado/user"
  autoload :UserEmail, "avocado/user_email"
  autoload :UserTokens, "avocado/user_tokens"
  autoload :UserPassword, "avocado/user_password"
end
