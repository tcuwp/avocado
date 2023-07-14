# frozen_string_literal: true

require "active_support/concern"

module Avocado
  module UserPasswordConcern
    extend ActiveSupport::Concern

    REQUIRED_LENGTH = 8

    included do
      has_secure_password

      validates :password, length: {minimum: REQUIRED_LENGTH}
    end
  end
end
