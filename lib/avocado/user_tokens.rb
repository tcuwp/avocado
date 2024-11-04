module Avocado
  module UserTokens
    extend ActiveSupport::Concern

    EXPIRES_FAST = 16.minutes
    EXPIRES_LATER = 64.minutes
    EXPIRES_LONG = 2_048.minutes

    included do
      generates_token_for :email_affirmation, expires_in: EXPIRES_FAST

      generates_token_for :email_verification, expires_in: EXPIRES_LONG do
        email_address
      end
    end
  end
end
