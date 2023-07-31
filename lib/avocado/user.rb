module Avocado
  module User
    extend ActiveSupport::Concern

    included do
      include UserCallbacks
      include UserTokens
      include UserValidations

      has_secure_password

      with_options dependent: :destroy do
        has_many :events
        has_many :sessions
      end

      scope :newest_first, -> { order(created_at: :desc) }
      scope :verified, -> { where(verified: true) }

      normalizes :email, with: ->(email) { email.downcase.strip }
    end
  end
end
