require "avocado"
require "rails/engine"

module Avocado
  class Engine < Rails::Engine
    initializer :avocado_routing do
      ActiveSupport.on_load(:action_dispatch_request) do
        ActionDispatch::Routing::Mapper.define_method(:🥑) { :avocado }
      end
    end
  end
end
