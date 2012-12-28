# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'schema_tools/version'

Gem::Specification.new do |s|
  s.name        = 'json_schema_tools'
  s.version     = SchemaBuilder::VERSION
  s.authors     = ['Georg Leciejewski']
  s.email       = ['gl@salesking.eu']
  s.homepage    = 'http://www.salesking.eu/dev'
  s.summary     = %q{JSON Schema API tools.}
  s.description = %q{Want to create a JSON Schema powered API? This toolset provides methods to read schemata, render objects as defined in schema, clean parameters according to schema, ...}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'json'
  s.add_dependency 'activesupport'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'rspec'
end