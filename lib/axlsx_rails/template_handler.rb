# frozen_string_literal: true

require 'stringio'

module AxlsxRails
  class TemplateHandler
    def default_format
      Mime[:xlsx].symbol
    end

    def call(template, source = nil)
      builder = StringIO.new
      builder << "require 'caxlsx';"
      builder << "xlsx_author = defined?(xlsx_author).nil? ? nil : xlsx_author;"
      builder << "xlsx_created_at = defined?(xlsx_created_at).nil? ? nil : xlsx_created_at;"
      builder << "xlsx_use_shared_strings = defined?(xlsx_use_shared_strings).nil? ? nil : xlsx_use_shared_strings;"
      builder << "xlsx_package = Axlsx::Package.new("
      builder << ":author => xlsx_author,"
      builder << ":created_at => xlsx_created_at,"
      builder << ":use_shared_strings => xlsx_use_shared_strings);"
      builder << (source || template.source)
      builder << "\n;xlsx_package.to_stream.string;"
      builder.string
    end
  end
end
