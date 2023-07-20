# frozen_string_literal: true

require_relative "avocado/engine"

module Avocado
  class Error < StandardError; end

  autoload :Authentication, "avocado/authentication"
  autoload :Current, "avocado/current"
  autoload :Event, "avocado/event"
  autoload :Mailer, "avocado/mailer"
  autoload :Session, "avocado/session"
  autoload :User, "avocado/user"
  autoload :UserTokens, "avocado/user_tokens"
  autoload :UserValidations, "avocado/user_validations"
end
