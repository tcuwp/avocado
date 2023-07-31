module Avocado
  module UserTokens
    extend ActiveSupport::Concern

    EXPIRES_FAST = 16.minutes
    EXPIRES_LATER = 64.minutes
    EXPIRES_LONG = 2_048.minutes

    included do
      generates_token_for :email_affirmation, expires_in: EXPIRES_FAST

      generates_token_for :email_verification, expires_in: EXPIRES_LONG do
        email
      end

      generates_token_for :password_reset, expires_in: EXPIRES_LATER do
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
