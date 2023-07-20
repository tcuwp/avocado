# frozen_string_literal: true

module Avocado
  module Session
    extend ActiveSupport::Concern

    included do
      belongs_to :user

      scope :newest_first, -> { order(created_at: :desc) }

      after_create :record_activity_create

      after_destroy :record_activity_destroy
    end

    def record_activity_create
      user.events.create! action: "session:create"
    end

    def record_activity_destroy
      user.events.create! action: "session:destroy"
    end
  end
end
