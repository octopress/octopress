# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'octopress/version'

Gem::Specification.new do |spec|
  spec.name          = "octopress"
  spec.version       = Octopress::VERSION
  spec.authors       = ["Brandon Mathis", "Parker Moore"]
  spec.email         = ["brandon@imathis.com", "parkrmoore@gmail.com"]
  spec.description   = %q{Octopress is an obsessively designed framework for Jekyll blogging. It’s easy to configure and easy to deploy. Sweet huh?}
  spec.summary       = %q{Octopress is an obsessively designed framework for Jekyll blogging. It’s easy to configure and easy to deploy. Sweet huh?}
  spec.homepage      = "http://octopress.org"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "mercenary", "~> 0.3.2"
  spec.add_runtime_dependency "jekyll", "~> 2.0"
  spec.add_runtime_dependency "titlecase"
  spec.add_runtime_dependency "octopress-docs"
  spec.add_runtime_dependency "octopress-deploy"

  spec.add_development_dependency "octopress-ink"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  if RUBY_VERSION >= "2"
    spec.add_development_dependency "pry-byebug"
  end
end
