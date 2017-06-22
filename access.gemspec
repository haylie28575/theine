# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'access/version'

Gem::Specification.new do |spec|
  spec.name          = "access"
  spec.version       = Access::VERSION
  spec.authors       = ["Ben Eggett", "Quintin Adam", "Cody Stringham"]
  spec.email         = ["beneggett@gmail.com"]
  spec.summary       = %q{Ruby wrapper for Access API}
  spec.description   = %q{Ruby wrapper for Access API}
  spec.homepage      = "http://www.github.com/access-development/api-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-minitest"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "minitest-focus"
  spec.add_development_dependency "dotenv"

  spec.add_dependency "hashie", "~> 3.3.1"
  spec.add_dependency "httparty", "~> 0.13.3"
end
