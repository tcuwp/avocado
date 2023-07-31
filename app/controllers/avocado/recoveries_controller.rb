module Avocado
  class RecoveriesController < BaseController
    UPDATE_PARAMETERS = %i[password password_confirmation]

    skip_before_action :authenticate

    before_action :set_user, only: %i[edit update]
    before_action :verify_user, only: :create

    def new
    end

    def create
      send_password_reset_email
      redirect_to new_session_path,
        notice: t(".success")
    end

    def edit
    end

    def update
      if @user.update(update_parameters)
        redirect_to new_session_path,
          notice: t(".success")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = user_from_signed_password_reset_token
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_recovery_path,
        alert: t(".errors.invalid_token")
    end

    def user_from_signed_password_reset_token
      ::User.find_by_token_for!(:password_reset, params[:id])
    end

    def verify_user
      unless requested_verified_user
        redirect_to new_recovery_path,
          alert: t(".errors.unverified_email")
      end
    end

    def update_parameters
      params
        .require(:user)
        .permit(UPDATE_PARAMETERS)
    end

    def send_password_reset_email
      mailer_for(requested_verified_user)
        .password_reset
        .deliver_later
    end
  end
end
