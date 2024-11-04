module Avocado
  module User
    extend ActiveSupport::Concern

    included do
      include UserCallbacks
      include UserTokens
      include UserValidations

      with_options dependent: :destroy do
        has_many :events
      end

      scope :newest_first, -> { order(created_at: :desc) }
      scope :verified, -> { where(verified: true) }
    end
  end
end
