# frozen_string_literal: true

module Avocado
  class RegistrationsController < BaseController
    PERMITTED_PARAMS = %i[email password password_confirmation]

    skip_before_action :authenticate

    def new
      @user = ::User.new
    end

    def create
      @user = ::User.new(user_params)

      if @user.save
        sign_in(@user)

        send_email_verification
        redirect_to root_path, notice: "Registration successful"
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params
        .require(:user)
        .permit(PERMITTED_PARAMS)
    end

    def send_email_verification
      mailer_for(@user)
        .email_verification
        .deliver_later
    end
  end
end
