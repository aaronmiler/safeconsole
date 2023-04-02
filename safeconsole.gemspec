# frozen_string_literal: true

require_relative "lib/safeconsole/version"

Gem::Specification.new do |spec|
  spec.name = "safeconsole"
  spec.version = Safeconsole::VERSION
  spec.authors = ["Aaron Miler"]
  spec.email = ["aaron@miler.to"]

  spec.summary = "A safer version of rails console with Pry and Transactions"
  spec.description = <<~DESC
    A pry console that's safe for production use. Safeconsole wraps your console usage in
     a transaction, allowing you to be sure of the actions you're taking, and preventing
     accidental modifications to production data.
  DESC
  spec.homepage = "https://github.com/aaromiler/safeconsole"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/aaronmiler/safeconsole"
  spec.metadata["changelog_uri"] = "https://github.com/aaronmiler/safeconsole/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "pry"
  spec.add_dependency "artii"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
