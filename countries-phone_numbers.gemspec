# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'countries/phone_numbers/version'

Gem::Specification.new do |spec|
  spec.name          = "countries-phone_numbers"
  spec.version       = Countries::PhoneNumbers::VERSION
  spec.authors       = ["Ian Lloyd"]
  spec.email         = ["ian.w.lloyd@me.com"]
  spec.description   = %q{Find countries by phone numbers}
  spec.summary       = %q{Integrate phone number searching into the Country gem using Phony}
  spec.homepage      = "http://github.com/illoyd/countries-phone_numbers"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'countries', '>= 0.9'
  spec.add_dependency 'phony', '>= 1.9'
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "json"
  spec.add_development_dependency "simplecov"
  
end
