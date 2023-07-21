# frozen_string_literal: true

module Avocado
  module Session
    extend ActiveSupport::Concern

    included do
      belongs_to :user

      scope :newest_first, -> { order(created_at: :desc) }

      after_create :record_activity_create

      after_destroy :record_activity_destroy

      before_create :capture_request_details
    end

    private

    def record_activity_create
      create_user_event "session:create"
    end

    def record_activity_destroy
      create_user_event "session:destroy"
    end

    def create_user_event(action)
      user.events.create! action: action
    end

    def capture_request_details
      self.user_agent = Current.user_agent
      self.ip_address = Current.ip_address
    end
  end
end
