module Avocado
  class VerificationsController < BaseController
    with_options only: %i[edit update] do
      skip_before_action :authenticate
      before_action :set_user
    end

    def edit
    end

    def update
      @user.update! verified: true
      redirect_to root_path, notice: "Email address verified."
    end

    def create
      send_email_verification
      redirect_to root_path, notice: "Verification email sent to your address."
    end

    private

    def set_user
      @user = user_from_signed_email_verification_token
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to root_path, alert: "Email verification link is invalid."
    end

    def user_from_signed_email_verification_token
      ::User.find_by_token_for!(:email_verification, params[:id])
    end

    def send_email_verification
      mailer_for(current_user)
        .email_verification
        .deliver_later
    end
  end
end
