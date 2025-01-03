if ENV.fetch("COVERAGE", false)
  require "simplecov"
  SimpleCov.start do
    load_profile "test_frameworks"
  end
end

require "rails/all"

Bundler.require :default, :development
Combustion.initialize! :all do
  config.load_defaults Rails::VERSION::STRING.to_f
  config.action_mailer.delivery_method = :test
  config.active_job.queue_adapter = :inline
end

require "factory_bot_rails"
require "capybara/rails"
require "rspec/rails"

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].sort.each { |file| require file }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.infer_spec_type_from_file_location!

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random

  config.use_transactional_fixtures = true

  config.include FactoryBot::Syntax::Methods
  config.include ActiveSupport::Testing::TimeHelpers
  config.include SystemSpecHelper, type: :system

  config.before(:each, type: :system) do
    driven_by :rack_test
  end
end
