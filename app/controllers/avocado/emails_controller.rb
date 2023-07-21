# frozen_string_literal: true

module Avocado
  class EmailsController < BaseController
    PERMITTED_PARAMS = [:email]

    before_action :set_user
    before_action :verify_password_challenge, only: :update

    def edit
    end

    def update
      if @user.update(user_params)
        process_email_update
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = current_user
    end

    def user_params
      params
        .require(:user)
        .permit(PERMITTED_PARAMS)
    end

    def process_email_update
      if @user.email_previously_changed?
        resend_email_verification
        redirect_to root_path, notice: "Your email has been changed"
      else
        redirect_to root_path
      end
    end

    def resend_email_verification
      mailer_for(@user)
        .email_verification
        .deliver_later
    end
  end
end
