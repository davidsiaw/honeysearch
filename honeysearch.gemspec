require_relative 'lib/honeysearch/version'

Gem::Specification.new do |spec|
  spec.name          = "honeysearch"
  spec.version       = Honeysearch::VERSION
  spec.authors       = ["David Siaw"]
  spec.email         = ["davidsiaw@gmail.com"]

  spec.summary       = %q{search karaoke}
  spec.description   = %q{search karaoke}
  spec.homepage      = "https://github.com/davidsiaw/honeysearch"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/davidsiaw/honeysearch"
  spec.metadata["changelog_uri"] = "https://github.com/davidsiaw/honeysearch"

  spec.files = Dir['{data,exe,lib,bin}/**/*'] +
               %w[Gemfile honeysearch.gemspec]
  spec.test_files    = Dir['{spec,features}/**/*']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
