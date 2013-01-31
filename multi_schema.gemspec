# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'multi_schema/version'

Gem::Specification.new do |gem|
  gem.name          = "multi_schema"
  gem.version       = MultiSchema::VERSION
  gem.authors       = ["Vlad Bokov"]
  gem.email         = ["razum2um@mail.ru"]
  gem.description   = %q{Allows you to switch over the postgres schemas in runtime inside ruby/rails}
  gem.summary       = %q{Path switch for postgresql tables accross schemas}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency("rake")
  gem.add_dependency("activesupport", "> 3.2")

  gem.add_development_dependency('rspec')
end
