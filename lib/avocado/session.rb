# frozen_string_literal: true

module Avocado
  module Session
    extend ActiveSupport::Concern

    included do
      include SessionCallbacks

      belongs_to :user

      scope :newest_first, -> { order(created_at: :desc) }
      scope :non_current, -> { where.not(id: Current.session) }
    end
  end
end
