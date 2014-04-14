require "spreadsheetable/version"

module Spreadsheetable
  def self.extend_object(base)
    raise TypeError.new unless base.is_a?(ActiveRecord::Relation) || (base.is_a?(Array) && base.first.is_a?(ActiveRecord::Base))
    super
  end
end
