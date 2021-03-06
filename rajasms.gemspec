# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rajasms/version'

Gem::Specification.new do |spec|
  spec.name          = "rajasms"
  spec.version       = Rajasms::VERSION
  spec.authors       = ["Fajar Maulana Firdaus"]
  spec.email         = ["fajarmf@gmail.com"]
  spec.summary       = %q{Simple wrapper to raja-sms.com service.}
  spec.description   = %q{For regular sms.}
  spec.homepage      = "https://github.com/fajarmf/rajasms"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "httparty"
end
