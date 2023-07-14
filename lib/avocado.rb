# frozen_string_literal: true

require_relative "avocado/version"
require_relative "avocado/user_concern"
require_relative "avocado/user_email_concern"
require_relative "avocado/user_password_concern"

module Avocado
  class Error < StandardError; end
end
