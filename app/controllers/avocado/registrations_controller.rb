module Avocado
  class RegistrationsController < BaseController
    def new
      @user = ::User.new
    end
  end
end
