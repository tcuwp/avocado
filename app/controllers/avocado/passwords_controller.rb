# frozen_string_literal: true

module Avocado
  class PasswordsController < BaseController
    UPDATE_PARAMETERS = %i[password password_confirmation password_challenge]

    before_action :set_user
    before_action :verify_password_challenge, only: :update

    def edit
    end

    def update
      if @user.update(update_parameters)
        redirect_to root_path, notice: "Your password has been changed"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = current_user
    end

    def update_parameters
      params
        .require(:user)
        .permit(UPDATE_PARAMETERS)
        .with_defaults(password_challenge: "")
    end
  end
end
