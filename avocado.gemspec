require_relative "lib/avocado/version"

Gem::Specification.new do |spec|
  spec.name = "avocado"
  spec.version = Avocado::VERSION
  spec.authors = ["Matt Jankowski"]
  spec.email = ["info@tcuwp.co"]

  spec.summary = "Simple authentication for Rails applications"
  spec.homepage = "https://github.com/tcuwp/avocado"
  spec.license = "MIT"
  spec.required_ruby_version = Avocado::MINIMUM_RUBY_VERSION

  spec.metadata["bug_tracker_uri"] = "https://github.com/tcuwp/avocado/issues"
  spec.metadata["changelog_uri"] = "https://github.com/tcuwp/avocado/blob/main/CHANGELOG.md"
  spec.metadata["documentation_uri"] = "https://github.com/tcuwp/avocado/blob/main/docs/USAGE.md"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/tcuwp/avocado/tree/main"
  spec.metadata["wiki_uri"] = "https://github.com/tcuwp/avocado/wiki"

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

  spec.add_dependency "bcrypt", "~> 3.1"
  spec.add_dependency "rails", Avocado::RAILS_VERSION
end
