# frozen_string_literal: true

require_relative "avocado/version"

module Avocado
  class Error < StandardError; end

  autoload :UserConcern, "avocado/user_concern"
  autoload :UserEmailConcern, "avocado/user_email_concern"
  autoload :UserPasswordConcern, "avocado/user_password_concern"
end
