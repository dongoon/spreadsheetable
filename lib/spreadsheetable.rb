require "spreadsheetable/version"

module Spreadsheetable
  attr_reader :sheet_columns

  def self.extend_object(base)
    raise TypeError.new unless base.is_a?(ActiveRecord::Relation) || (base.is_a?(Array) && base.first.is_a?(ActiveRecord::Base))
    base.instance_variable_set(:@sheet_columns, [])
    super
  end
end
