# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'firstmiler_sms_oauth/version'

Gem::Specification.new do |spec|
  spec.name          = "firstmiler_sms_oauth"
  spec.version       = FirstmilerSmsOauth::VERSION
  spec.authors       = ["raudra"]
  spec.email         = ["raudrachamp10@gmail.com"]
  spec.description   = "Common library for sending sms and OTP verification"
  spec.summary       = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir['lib/**/*.rb']
  # spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency 'activerecord',  ['>= 3.2', '< 5']

  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'mysql2', '~> 0.3.7'
  spec.add_development_dependency 'ruby-oci8'
  spec.add_development_dependency "bundler", "~> 1.0.0"
  # spec.add_development_dependency 'exotel'#, :git => 'git@github.com:raudra/exotel.git'
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
end
