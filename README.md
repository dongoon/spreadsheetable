# Spreadsheetable[![Build Status](https://travis-ci.org/dongoon/spreadsheetable.svg?branch=master)](https://travis-ci.org/dongoon/spreadsheetable)

A scope(ActiveRecord::Relation) and a array of active_record are able to be spreadsheet with this module.

## Installation

Add this line to your application's Gemfile:

    gem 'spreadsheetable'

And then execute:

    $ bundle

## Usage

```ruby
scope = AModel.all #scope or array
scope.sheet_columns = %w(id name other)
xls_file = scope.xls # or scope.to_spreadsheet
```

## Contributing

1. Fork it ( http://github.com/dongoon/spreadsheetable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
