# frozen_string_literal: true

require "active_support/concern"

module Avocado
  module UserPasswordConcern
    extend ActiveSupport::Concern

    REQUIRED_FORMAT = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).*\z/x
    REQUIRED_LENGTH = 8

    included do
      has_secure_password

      validates :password, format: {with: REQUIRED_FORMAT}, length: {minimum: REQUIRED_LENGTH}
    end
  end
end
