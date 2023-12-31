# frozen_string_literal: true

require_relative "lib/slack_layout/version"

Gem::Specification.new do |spec|
  spec.name = "slack_layout"
  spec.version = VERSION
  spec.authors = ["Borja Garcia de Vinuesa Ordovas"]
  spec.email = ["hi@bgvo.io"]

  spec.summary = "Build Slack layouts with ease using BlockKit"
  spec.description = "Pretty easy to use gem to build Slack layouts using BlockKit."
  spec.homepage = "https://bgvo.io"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'https://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_runtime_dependency "slack-ruby-block-kit"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
