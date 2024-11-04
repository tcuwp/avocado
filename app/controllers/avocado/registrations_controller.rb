module Avocado
  class RegistrationsController < BaseController
    INITIALIZATION_PARAMETERS = %i[email_address password password_confirmation]

    allow_unauthenticated_access

    def new
      @user = ::User.new
    end

    def create
      @user = ::User.new(initialization_parameters)

      if @user.save
        start_new_session_for(@user)

        send_email_verification(@user)
        redirect_to root_path,
          notice: t(".success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def initialization_parameters
      params
        .require(:user)
        .permit(INITIALIZATION_PARAMETERS)
    end
  end
end
