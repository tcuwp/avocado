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
      redirect_to root_path,
        notice: t(".success")
    end

    def create
      send_email_verification(current_user)
      redirect_to root_path,
        notice: t(".success")
    end

    private

    def set_user
      @user = user_from_signed_email_verification_token
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to root_path,
        alert: t(".errors.invalid_token")
    end

    def user_from_signed_email_verification_token
      ::User
        .find_by_token_for!(:email_verification, params[:id])
    end
  end
end
