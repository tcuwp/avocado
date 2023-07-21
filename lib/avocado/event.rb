# frozen_string_literal: true

module Avocado
  module Event
    extend ActiveSupport::Concern

    VALID_ACTIONS = [
      "password:update",
      "session:create",
      "session:destroy"
    ]

    included do
      belongs_to :user

      scope :newest_first, -> { order(created_at: :desc) }

      validates :action, inclusion: VALID_ACTIONS

      before_create :capture_request_details
    end

    private

    def capture_request_details
      self.user_agent = Current.user_agent
      self.ip_address = Current.ip_address
    end
  end
end
