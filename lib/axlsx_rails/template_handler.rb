require 'action_view'
module ActionView
  module Template::Handlers
    class AxlsxBuilder
      def default_format
        Mime::XLSX
      end

      def self.call(template)
        "xlsx_author = defined?(xlsx_author).nil? ? nil : xlsx_author;\n" +
        "xlsx_created_at = defined?(xlsx_created_at).nil? ? nil : xlsx_created_at;\n" +
        "xlsx_use_shared_strings = defined?(xlsx_use_shared_strings).nil? ? nil : xlsx_use_shared_strings;\n" +
        "xlsx_package = Axlsx::Package.new(\n" +
          ":author => xlsx_author,\n" +
          ":created_at => xlsx_created_at,\n" +
          ":use_shared_strings => xlsx_use_shared_strings\n" +
          ");\n" +
        template.source +
        ";\nxlsx_package.to_stream.string;"
      end

    end
  end
end

ActionView::Template.register_template_handler :axlsx, ActionView::Template::Handlers::AxlsxBuilder
