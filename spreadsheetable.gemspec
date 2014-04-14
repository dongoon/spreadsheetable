# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spreadsheetable/version'

Gem::Specification.new do |spec|
  spec.name          = "spreadsheetable"
  spec.version       = Spreadsheetable::VERSION
  spec.authors       = ["Yasuhiko Maeda"]
  spec.email         = ["y.maeda@dongoon.jp"]
  spec.summary       = %q{ActiveRecord::Relation to SpreadSheet}
  spec.description   = %q{This module implement [to_spreadsheet | xls] to ActiveRecord::Relation}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "sqlite3-ruby"
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "factory_girl_rails"

  spec.add_runtime_dependency "activerecord", ">= 3.0.0"
  spec.add_runtime_dependency "arel", ">= 3.0.0"
  spec.add_runtime_dependency "spreadsheet", "~> 0.9.7"
end
