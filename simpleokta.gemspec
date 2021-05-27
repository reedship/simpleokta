require_relative 'lib/simpleokta/version'

Gem::Specification.new do |spec|
  spec.name          = "simpleokta"
  spec.version       = Simpleokta::VERSION
  spec.authors       = ["Braden Shipley"]
  spec.email         = ["simpleokta@gmail.com"]

  spec.summary       = "A Simple Okta Gem that helps perform common Okta Calls."
  spec.description   = "A Simple Okta Gem that helps perform common Okta Calls."
  spec.homepage      = "https://github.com/bradenshipley/simpleokta"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.0")

  spec.metadata["allowed_push_host"] = "http://mygemserver.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/bradenshipley/simpleokta"
  spec.metadata["changelog_uri"] = "https://github.com/bradenshipley/simpleokta/changelog.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  # Gem Dependencies
  spec.add_dependency("faraday")
  spec.add_dependency("rack")
end
