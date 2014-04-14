require "spreadsheetable/version"

module Spreadsheetable
  attr_reader :sheet_columns

  def self.extend_object(base)
    raise TypeError.new unless base.is_a?(ActiveRecord::Relation) || (base.is_a?(Array) && base.first.is_a?(ActiveRecord::Base))
    base.instance_variable_set(:@sheet_columns, [])
    super
  end

  def sheet_columns= cols
    raise TypeError unless cols.is_a?(Array)
    @sheet_columns = cols
  end

  def _sheet_header
    default = self.is_a?(ActiveRecord::Relation) ? self.klass : self.first.class

    self.sheet_columns.collect{|col|
      names = col.to_s.split(".")
      if names.count == 1
        model = default
      else
        model = names[names.count - 2].classify.constantize
      end
      model.human_attribute_name names.last
    }
  end

  private :_sheet_header
end
