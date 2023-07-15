# frozen_string_literal: true

require "active_support/concern"

module Avocado
  module User
    extend ActiveSupport::Concern

    included do
      include UserEmailConcern
      include UserPasswordConcern
    end
  end
end
