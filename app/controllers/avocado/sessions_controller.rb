# frozen_string_literal: true

module Avocado
  class SessionsController < BaseController
    PERMITTED_PARAMS = [:email, :password]

    skip_before_action :authenticate, only: [:new, :create]

    with_options only: :create do
      before_action :verify_authentication_attempt
    end

    before_action :set_session, only: :destroy

    def index
      @sessions = current_user.sessions.newest_first
    end

    def new
      @session = ::Session.new
    end

    def create
      sign_in(authenticated_user)

      redirect_to root_path, notice: "Session created"
    end

    def destroy
      @session.destroy
      redirect_to sessions_path, notice: "Session destroyed"
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
        redirect_to new_session_path, alert: "Authentication failed"
      end
    end

    def set_session
      @session = current_user.sessions.find(params[:id])
    end
  end
end
