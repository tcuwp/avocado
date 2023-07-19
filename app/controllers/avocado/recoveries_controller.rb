# frozen_string_literal: true

module Avocado
  class RecoveriesController < BaseController
    PERMITTED_PARAMS = %i[password password_confirmation]

    skip_before_action :authenticate

    before_action :set_user, only: %i[edit update]
    before_action :verify_user, only: :create

    def new
    end

    def edit
    end

    def create
      send_password_reset_email
      redirect_to new_session_path, notice: "Check your email for reset instructions."
    end

    def update
      if @user.update(user_params)
        redirect_to new_session_path, notice: "Password reset successfully. Please sign in."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = user_from_signed_password_reset_token
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_recovery_path, alert: "Password reset link is invalid."
    end

    def user_from_signed_password_reset_token
      ::User.find_by_token_for!(:password_reset, params[:id])
    end

    def verify_user
      unless user_from_params_email
        redirect_to new_recovery_path, alert: "Verify email first before resetting password."
      end
    end

    def user_params
      params
        .require(:user)
        .permit(PERMITTED_PARAMS)
    end

    def user_from_params_email
      ::User.find_by(email: params[:email], verified: true)
    end

    def send_password_reset_email
      mailer_for(user_from_params_email)
        .password_reset
        .deliver_later
    end
  end
end
