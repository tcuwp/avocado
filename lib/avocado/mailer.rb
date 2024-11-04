module Avocado
  class Mailer < ApplicationMailer
    before_action :set_user
    before_action :set_signed_id

    default to: -> { @user.email_address }

    def email_affirmation
      mail
    end

    def email_verification
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
