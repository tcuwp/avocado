# frozen_string_literal: true

require "active_support/concern"

module Avocado
  module UserPasswordRecovery
    extend ActiveSupport::Concern

    TOKEN_EXPIRATION = 64.minutes

    included do
      generates_token_for :password_recovery, expires_in: TOKEN_EXPIRATION do
        password_digest_salt
      end
    end

    private

    def password_digest_salt
      password_from_digest.salt[-10..]
    end

    def password_from_digest
      BCrypt::Password.new(password_digest)
    end
  end
end
