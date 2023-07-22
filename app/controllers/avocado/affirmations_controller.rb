# frozen_string_literal: true

module Avocado
  class AffirmationsController < BaseController
    PERMITTED_PARAMS = [:email]

    skip_before_action :authenticate

    before_action :set_user, only: %i[edit update]
    before_action :verify_user, only: :create

    def new
    end

    def create
      send_affirmation_email
      redirect_to new_session_path, notice: "Check your email for sign in instructions"
    end

    def edit
    end

    def update
      sign_in(@user)
      redirect_to(root_path, notice: "Signed in successfully")
    end

    private

    def set_user
      @user = user_from_signed_affirmation_token
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_affirmation_path, alert: "That sign in link is invalid"
    end

    def user_from_signed_affirmation_token
      ::User.find_by_token_for!(:email_affirmation, params[:id])
    end

    def verify_user
      unless requested_verified_user
        redirect_to new_affirmation_path, alert: "You can't sign in until you verify your email"
      end
    end

    def send_affirmation_email
      mailer_for(requested_verified_user)
        .email_affirmation
        .deliver_later
    end

    def requested_verified_user
      ::User.verified.find_by(email: user_params[:email])
    end

    def user_params
      params
        .require(:user)
        .permit(PERMITTED_PARAMS)
    end
  end
end
