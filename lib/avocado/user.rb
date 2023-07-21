# frozen_string_literal: true

module Avocado
  module User
    extend ActiveSupport::Concern

    included do
      include UserTokens
      include UserValidations

      has_secure_password

      with_options dependent: :destroy do
        has_many :events
        has_many :sessions
      end

      scope :newest_first, -> { order(created_at: :desc) }
      scope :verified, -> { where(verified: true) }

      normalizes :email, with: ->(email) { email.downcase.strip }

      after_update :record_activity_email_update, if: :email_previously_changed?
      after_update :record_activity_email_verified, if: %i[verified_previously_changed? verified?]
      after_update :record_activity_password_update, if: :password_digest_previously_changed?

      before_validation :remove_email_verification, if: :email_changed?, on: :update
    end

    private

    def record_activity_password_update
      events.create! action: "password:update"
    end

    def record_activity_email_update
      events.create! action: "email:update"
    end

    def record_activity_email_verified
      events.create! action: "email:verified"
    end

    def remove_email_verification
      self.verified = false
    end
  end
end
