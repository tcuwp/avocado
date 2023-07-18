# frozen_string_literal: true

module Avocado
  class RegistrationsController < BaseController
    def new
      @user = ::User.new
    end
  end
end
