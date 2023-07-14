# frozen_string_literal: true

require "active_support/concern"

module Avocado
  module UserPasswordConcern
    extend ActiveSupport::Concern

    REQUIRED_FORMAT = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).*\z/x
    REQUIRED_LENGTH = 8
    TOKEN_EXPIRATION = 64.minutes

    included do
      has_secure_password

      validates :password, format: {with: REQUIRED_FORMAT}, length: {minimum: REQUIRED_LENGTH}, allow_nil: true

      generates_token_for :password_recovery, expires_in: TOKEN_EXPIRATION do
        password_digest_salt
      end
    end

    private

    def password_digest_salt
      BCrypt::Password.new(password_digest).salt[-10..]
    end
  end
end
