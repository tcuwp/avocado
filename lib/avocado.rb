# frozen_string_literal: true

require_relative "avocado/version"

module Avocado
  class Error < StandardError; end

  autoload :User, "avocado/user"
  autoload :UserEmail, "avocado/user_email"
  autoload :UserPassword, "avocado/user_password"
  autoload :UserPasswordRecovery, "avocado/user_password_recovery"
end
