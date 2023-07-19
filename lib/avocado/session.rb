# frozen_string_literal: true

module Avocado
  module Session
    extend ActiveSupport::Concern

    included do
      belongs_to :user

      scope :newest_first, -> { order(created_at: :desc) }
    end
  end
end
