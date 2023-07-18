# frozen_string_literal: true

module Avocado
  class SessionsController < BaseController
    PERMITTED_PARAMS = [:email, :password]

    skip_before_action :authenticate, only: [:new, :create]

    with_options only: :create do
      before_action :verify_authentication_attempt
    end

    def new
      @session = ::Session.new
    end

    def create
      sign_in(authenticated_user)

      redirect_to root_path, notice: "Signed in successfully"
    end

    private

    def session_params
      params
        .require(:session)
        .permit(PERMITTED_PARAMS)
        .with_defaults(email: "", password: "")
    end

    def authenticated_user
      @_authenticated_user ||= ::User.authenticate_by(session_params)
    end

    def verify_authentication_attempt
      if authenticated_user.blank?
        redirect_to new_session_path, alert: "That email or password is incorrect"
      end
    end
  end
end
