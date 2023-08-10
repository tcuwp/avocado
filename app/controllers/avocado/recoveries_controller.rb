module Avocado
  class RecoveriesController < BaseController
    skip_before_action :authenticate

    before_action :verify_user,
      only: :create

    def new
    end

    def create
      send_password_reset_email
      redirect_to new_session_path,
        notice: t(".success")
    end

    private

    def verify_user
      unless requested_verified_user
        redirect_to new_recovery_path,
          alert: t(".errors.unverified_email")
      end
    end

    def send_password_reset_email
      mailer_for(requested_verified_user)
        .password_reset
        .deliver_later
    end
  end
end
