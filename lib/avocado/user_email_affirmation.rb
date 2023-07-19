# frozen_string_literal: true

module Avocado
  module UserEmailAffirmation
    extend ActiveSupport::Concern

    TOKEN_EXPIRATION = 16.minutes

    included do
      generates_token_for :email_affirmation, expires_in: TOKEN_EXPIRATION
    end
  end
end
