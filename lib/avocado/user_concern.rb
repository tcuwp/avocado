# frozen_string_literal: true

require "active_support/concern"

module Avocado
  module UserConcern
    extend ActiveSupport::Concern

    included do
      has_secure_password

      validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}

      normalizes :email, with: ->(email) { email.downcase.strip }
    end
  end
end
