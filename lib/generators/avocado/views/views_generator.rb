require "rails/generators/base"

module Avocado
  class ViewsGenerator < Rails::Generators::Base
    source_root File.expand_path("../../../..", __dir__)

    def create_views
      directory source_directory, target_directory
    end

    private

    def source_directory
      "app/views/avocado"
    end

    def target_directory
      Rails.root.join("app/views/avocado")
    end
  end
end
