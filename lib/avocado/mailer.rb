# frozen_string_literal: true

require "active_support/concern"

module Avocado
  module Mailer
    extend ActiveSupport::Concern

    included do
      before_action :set_user
      before_action :set_signed_id

      default to: -> { @user.email }
    end

    def email_affirmation
      mail
    end

    def email_verification
      mail
    end

    def password_recovery
      mail
    end

    private

    def set_user
      @user = params[:user]
    end

    def set_signed_id
      @signed_id = @user.generate_token_for(action_name.to_sym)
    end
  end
end
