module Avocado
  module UserValidations
    extend ActiveSupport::Concern

    PASSWORD_FORMAT = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).*\z/x
    PASSWORD_MINIMUM_LENGTH = 8

    included do
      validates :email,
        presence: true,
        uniqueness: true,
        format: {with: URI::MailTo::EMAIL_REGEXP}

      validates :password,
        format: {with: PASSWORD_FORMAT},
        length: {minimum: PASSWORD_MINIMUM_LENGTH},
        allow_nil: true
    end
  end
end
