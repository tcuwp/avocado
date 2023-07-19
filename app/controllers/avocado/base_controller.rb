# frozen_string_literal: true

module Avocado
  class BaseController < ApplicationController
    private

    def mailer_for(user)
      Avocado::Mailer.with(user: user)
    end
  end
end
