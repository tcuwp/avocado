# frozen_string_literal: true

module Avocado
  module User
    extend ActiveSupport::Concern

    included do
      include UserEmail
      include UserEmailAffirmation
      include UserEmailVerification
      include UserPassword
      include UserPasswordReset

      has_many :sessions

      scope :newest_first, -> { order(created_at: :desc) }
      scope :verified, -> { where(verified: true) }
    end
  end
end
