# frozen_string_literal: true

module Avocado
  class PasswordsController < BaseController
    PERMITTED_PARAMS = [:password, :password_confirmation, :password_challenge]

    before_action :set_user
    before_action :verify_password_challenge, only: :update

    def edit
    end

    def update
      if @user.update(user_params)
        redirect_to root_path, notice: "Your password has been changed"
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
        .with_defaults(password_challenge: "")
    end
  end
end
