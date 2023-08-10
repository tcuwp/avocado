module Avocado
  class EmailsController < BaseController
    UPDATE_PARAMETERS = %i[email]

    before_action :set_user
    before_action :verify_password_challenge,
      only: :update

    def edit
    end

    def update
      if @user.update(update_parameters)
        process_email_update
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
    end

    def process_email_update
      if @user.email_previously_changed?
        send_email_verification(@user)
        redirect_to root_path,
          notice: t(".success")
      else
        redirect_to root_path
      end
    end
  end
end
