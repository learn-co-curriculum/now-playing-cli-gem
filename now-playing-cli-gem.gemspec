# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'now_playing/version'

Gem::Specification.new do |spec|
  spec.authors       = ["Avi Flombaum"]
  spec.email         = ["avi@learn.co"]
  spec.description   = %q{Movies playing}
  spec.summary       = %q{Movies playing}
  spec.homepage      = "https://learn.co"

  spec.files         = `git ls-files`.split($\)
  spec.executables   = ["now-playing"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.name          = "now-playing-cli-gem"
  spec.require_paths = ["lib"]
  spec.version       = NowPlaying::VERSION
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "pry"
end
