# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'natsjr/version'

Gem::Specification.new do |spec|
  spec.name          = "natsjr"
  spec.version       = NatsJr::VERSION
  spec.authors       = %w(Armin Pašalić)
  spec.email         = %w(armin@promptus-partners.de)

  spec.summary       = "NATS Based microframework"
  spec.description   = "Small microframework for writing services on top " \
                       "of the nats message queue"
  spec.homepage      = "https://github.com/promptus/natsjr"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
                                        .reject do |f|
                                          f.match(%r{^(test|spec|features)/})
                                        end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w(lib)

  spec.required_ruby_version = {
    jruby: ">= 9.0.1.0"
  }

  spec.add_dependency "lock_jar", "~> 0.15.0"
  spec.add_dependency "jrjackson", "~> 0.3"
  spec.add_dependency "multi_json", "~> 1.11"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 0.5"
end
