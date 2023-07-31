module Avocado
  module Session
    extend ActiveSupport::Concern

    SECURE_TOKEN_LENGTH = 64

    included do
      include SessionCallbacks

      has_secure_token length: SECURE_TOKEN_LENGTH, on: :initialize

      belongs_to :user

      validates :token, presence: true

      scope :newest_first, -> { order(created_at: :desc) }
      scope :non_current, -> { where.not(id: Current.session) }
    end
  end
end
