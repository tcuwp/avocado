# frozen_string_literal: true

require "avocado"
require "rails/engine"

module Avocado
  class Engine < Rails::Engine
    initializer "avocado.routing" do
      ActiveSupport.on_load(:action_dispatch_request) do
        ActionDispatch::Routing::Mapper.define_method(:🥑) { :🥑 }
      end
    end
  end
end
