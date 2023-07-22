# frozen_string_literal: true

module Avocado
  class BaseController < ApplicationController
    FINDER_PARAMETERS = %i[email]

    private

    def verify_password_challenge
      unless current_user.authenticate(params_password_challenge)
        redirect_back alert: "Password challenge failed.", fallback_location: root_path
      end
    end

    def params_password_challenge
      params.dig(:user, :password_challenge)
    end

    def requested_verified_user
      ::User.verified.find_by(email: finder_parameters[:email])
    end

    def finder_parameters
      params
        .require(:user)
        .permit(FINDER_PARAMETERS)
    end

    def mailer_for(user)
      Avocado::Mailer.with(user: user)
    end
  end
end
