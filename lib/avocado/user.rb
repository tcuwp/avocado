# frozen_string_literal: true

module Avocado
  module User
    extend ActiveSupport::Concern

    included do
      include UserTokens
      include UserValidations

      has_secure_password

      has_many :sessions

      scope :newest_first, -> { order(created_at: :desc) }
      scope :verified, -> { where(verified: true) }

      normalizes :email, with: ->(email) { email.downcase.strip }
    end
  end
end
