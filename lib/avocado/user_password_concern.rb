# frozen_string_literal: true

require "active_support/concern"

module Avocado
  module UserPasswordConcern
    extend ActiveSupport::Concern

    included do
      has_secure_password
    end
  end
end
