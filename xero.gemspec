# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xero/version'

Gem::Specification.new do |gem|
  gem.name          = "xero"
  gem.version       = Xero::VERSION
  gem.authors       = ["Matt Beedle"]
  gem.email         = ["mattbeedle@googlemail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('active_attr')
  gem.add_dependency('oauth')

  gem.add_development_dependency('fakeweb')
  gem.add_development_dependency('rspec')
  gem.add_development_dependency('shoulda-matchers')
  gem.add_development_dependency('vcr')
end
