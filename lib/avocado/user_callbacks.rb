module Avocado
  module UserCallbacks
    extend ActiveSupport::Concern

    included do
      with_options if: :password_digest_previously_changed? do
        after_update :destroy_non_current_sessions
        after_update :record_activity_password_update
      end

      after_update :record_activity_email_address_update, if: :email_address_previously_changed?
      after_update :record_activity_email_address_verified, if: %i[verified_previously_changed? verified?]

      before_validation :remove_email_verification, if: :email_address_changed?, on: :update
    end

    private

    def record_activity_password_update
      create_event "password:update"
    end

    def record_activity_email_address_update
      create_event "email_address:update"
    end

    def record_activity_email_address_verified
      create_event "email_address:verified"
    end

    def create_event(action)
      events.create! action: action
    end

    def remove_email_verification
      self.verified = false
    end

    def destroy_non_current_sessions
      sessions.non_current.destroy_all
    end
  end
end
