# frozen_string_literal: true

module Avocado
  module UserEmail
    extend ActiveSupport::Concern

    included do
      validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}

      normalizes :email, with: ->(email) { email.downcase.strip }
    end
  end
end
