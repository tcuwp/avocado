module Avocado
  module SessionCallbacks
    extend ActiveSupport::Concern

    included do
      after_create :record_activity_create

      after_destroy :record_activity_destroy
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
  end
end
