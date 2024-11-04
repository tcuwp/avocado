require "active_support"
require_relative "avocado/engine"

module Avocado
  class Error < StandardError; end

  autoload :Event, "avocado/event"
  autoload :Mailer, "avocado/mailer"
  autoload :Session, "avocado/session"
  autoload :SessionCallbacks, "avocado/session_callbacks"
  autoload :User, "avocado/user"
  autoload :UserCallbacks, "avocado/user_callbacks"
  autoload :UserTokens, "avocado/user_tokens"
  autoload :UserValidations, "avocado/user_validations"
end
