# frozen_string_literal: true

require "active_support/concern"

module Avocado
  module Session
    extend ActiveSupport::Concern

    included do
      belongs_to :user

      scope :newest_first, -> { order(created_at: :desc) }
    end
  end
end
