# frozen_string_literal: true

module Avocado
  module User
    extend ActiveSupport::Concern

    included do
      include UserEmail
      include UserEmailAffirmation
      include UserEmailVerification
      include UserPassword
      include UserPasswordReset

      has_many :sessions
    end
  end
end
