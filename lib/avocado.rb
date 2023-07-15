# frozen_string_literal: true

require_relative "avocado/version"

module Avocado
  class Error < StandardError; end

  autoload :User, "avocado/user"
  autoload :UserEmailConcern, "avocado/user_email_concern"
  autoload :UserPasswordConcern, "avocado/user_password_concern"
end
