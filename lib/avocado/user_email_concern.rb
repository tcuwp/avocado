# frozen_string_literal: true

require "active_support/concern"

module Avocado
  module UserEmailConcern
    extend ActiveSupport::Concern

    included do
      validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}

      normalizes :email, with: ->(email) { email.downcase.strip }
    end
  end
end
