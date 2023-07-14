# frozen_string_literal: true

require_relative "lib/avocado/version"

Gem::Specification.new do |spec|
  spec.name = "avocado"
  spec.version = Avocado::VERSION
  spec.authors = ["Matt Jankowski"]
  spec.email = ["matt@jankowski.online"]

  spec.summary = "Simple authentication for Rails (7.1+) applications"
  spec.homepage = "https://github.com/tcuwp/avocado"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/tcuwp/avocado"
  spec.metadata["changelog_uri"] = "https://github.com/tcuwp/avocado/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rails", "~> 7.1.0.alpha"
  spec.add_runtime_dependency "bcrypt"

  spec.add_development_dependency "combustion", "~> 1.3"
  spec.add_development_dependency "sqlite3"
end
