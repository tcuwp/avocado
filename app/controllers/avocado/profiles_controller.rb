module Avocado
  class ProfilesController < BaseController
    UPDATE_PARAMETERS = %i[password password_confirmation password_challenge]

    before_action :set_user
    before_action :verify_password_challenge,
      only: :update

    def edit
    end

    def update
      if @user.update(update_parameters)
        redirect_to root_path,
          notice: t(".success")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = Current.user
    end

    def update_parameters
      params
        .require(:user)
        .permit(UPDATE_PARAMETERS)
        .with_defaults(password_challenge: "")
    end
  end
end
