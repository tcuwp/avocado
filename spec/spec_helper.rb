# frozen_string_literal: true

if ENV.fetch("COVERAGE", false)
  require "simplecov"
  SimpleCov.start do
    load_profile "test_frameworks"
  end
end

require "rails/all"

Bundler.require :default, :development
Combustion.initialize! :all

require "factory_bot_rails"
require "rspec/rails"

Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |file| require file }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.infer_spec_type_from_file_location!

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.use_transactional_fixtures = true

  config.include FactoryBot::Syntax::Methods
  config.include ActiveSupport::Testing::TimeHelpers
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
