# frozen_string_literal: true

module Avocado
  class BaseController < ApplicationController
    private

    def verify_password_challenge
      unless current_user.authenticate(params_password_challenge)
        redirect_back alert: "Password challenge failed.", fallback_location: root_path
      end
    end

    def params_password_challenge
      params.dig(:user, :password_challenge)
    end

    def mailer_for(user)
      Avocado::Mailer.with(user: user)
    end
  end
end
