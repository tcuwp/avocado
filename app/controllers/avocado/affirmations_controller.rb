module Avocado
  class AffirmationsController < BaseController
    skip_before_action :authenticate

    before_action :set_user, only: %i[edit update]
    before_action :verify_user, only: :create

    def new
    end

    def create
      send_affirmation_email
      redirect_to new_session_path,
        notice: t(".success")
    end

    def edit
    end

    def update
      sign_in(@user)
      redirect_to root_path,
        notice: t(".success")
    end

    private

    def set_user
      @user = user_from_signed_affirmation_token
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_affirmation_path,
        alert: t(".errors.invalid_token")
    end

    def user_from_signed_affirmation_token
      ::User.find_by_token_for!(:email_affirmation, params[:id])
    end

    def verify_user
      unless requested_verified_user
        redirect_to new_affirmation_path,
          alert: t(".errors.unverified_email")
      end
    end

    def send_affirmation_email
      mailer_for(requested_verified_user)
        .email_affirmation
        .deliver_later
    end
  end
end
