require 'rspec'
require 'factory_girl'
require 'simplecov'
require 'coveralls'
require 'spreadsheetable'

# load spec/support/**/*.rb
Dir["#{File.dirname(__FILE__)}/support/*.rb"].each {|f| require f}

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter,
]

SimpleCov.start do
  add_filter "spec/support"
end if ENV['COVERAGE']

