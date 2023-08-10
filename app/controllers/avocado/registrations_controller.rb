module Avocado
  class RegistrationsController < BaseController
    INITIALIZATION_PARAMETERS = %i[email password password_confirmation]

    skip_before_action :authenticate

    def new
      @user = ::User.new
    end

    def create
      @user = ::User.new(initialization_parameters)

      if @user.save
        sign_in(@user)

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
