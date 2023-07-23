# frozen_string_literal: true

require "rails/generators/base"
require "rails/generators/active_record"

module Avocado
  class MigrationsGenerator < Rails::Generators::Base
    include ActiveRecord::Generators::Migration

    source_root File.expand_path("templates", __dir__)

    def create_migrations
      migration_template "create_users.rb", "#{db_migrate_path}/create_users.rb"
      migration_template "create_sessions.rb", "#{db_migrate_path}/create_sessions.rb"
      migration_template "create_events.rb", "#{db_migrate_path}/create_events.rb"
    end

    private

    def primary_and_foreign_key_types
      config = Rails.configuration.generators
      setting = config.options[config.orm][:primary_key_type]
      primary_key_type = setting || :primary_key
      foreign_key_type = setting || :bigint
      [primary_key_type, foreign_key_type]
    end

    def primary_key_type
      primary_and_foreign_key_types.first
    end

    def foreign_key_type
      primary_and_foreign_key_types.last
    end
  end
end
