# frozen_string_literal: true

module Avocado
  module UserEmailVerification
    extend ActiveSupport::Concern

    TOKEN_EXPIRATION = 2_048.minutes

    included do
      generates_token_for :email_verification, expires_in: TOKEN_EXPIRATION do
        email
      end
    end
  end
end
