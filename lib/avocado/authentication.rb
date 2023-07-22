# frozen_string_literal: true

module Avocado
  module Authentication
    extend ActiveSupport::Concern

    included do
      before_action :set_current_request_details
      before_action :authenticate

      helper_method :current_user
      helper_method :signed_in?
      helper_method :current_session
    end

    def current_user
      Current.user
    end

    def signed_in?
      current_user.present?
    end

    def current_session
      Current.session
    end

    private

    def authenticate
      if session_from_token
        Current.session = session_from_token
      else
        redirect_to new_session_path
      end
    end

    def sign_in(user)
      ::Session.create!(user: user).tap do |session|
        cookies.signed.permanent[:session_token] = {value: session.token, httponly: true}
      end
    end

    def session_from_token
      ::Session.find_by_token(cookies.signed[:session_token])
    end

    def set_current_request_details
      Current.user_agent = request.user_agent
      Current.ip_address = request.ip
    end
  end
end
