require "spreadsheetable/version"
require 'spreadsheet'

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

  def to_spreadsheet
    book = ::Spreadsheet::Workbook.new
    sheet = book.create_worksheet()

    rows = [_sheet_header]
    rows += self.collect{|_row| _to_row(_row)}
    rows.each_with_index do |_row, i|
      sheet.row(i).concat _row
    end

    tmpfile = Tempfile.new ["excel_tmp", ".xls"]
    book.write tmpfile

    tmpfile
  end

  def xls
    to_spreadsheet
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

  def _to_row record
    self.sheet_columns.collect{|c|
      eval("record." + c) rescue nil
    }
  end

  private :_sheet_header, :_to_row
end
