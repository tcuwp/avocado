module Avocado
  module Event
    extend ActiveSupport::Concern

    VALID_ACTIONS = [
      "email_address:update",
      "email_address:verified",
      "password:update",
      "session:create",
      "session:destroy"
    ]

    included do
      belongs_to :user

      scope :newest_first, -> { order(created_at: :desc) }

      validates :action, inclusion: VALID_ACTIONS

      before_create :capture_request_details, if: -> { Current.session.present? }
    end

    private

    def capture_request_details
      self.user_agent = Current.session.user_agent
      self.ip_address = Current.session.ip_address
    end
  end
end
