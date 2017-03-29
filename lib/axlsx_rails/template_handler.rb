require 'action_view'
module ActionView
  module Template::Handlers
    class AxlsxBuilder
      def default_format
        (Rails.version.to_f >= 5) ? Mime[:xlsx] : Mime::XLSX
      end

      def self.call(template)
        "xlsx_author = defined?(xlsx_author).nil? ? nil : xlsx_author;" +
        "xlsx_created_at = defined?(xlsx_created_at).nil? ? nil : xlsx_created_at;" +
        "xlsx_use_shared_strings = defined?(xlsx_use_shared_strings).nil? ? nil : xlsx_use_shared_strings;" +
        "xlsx_package = Axlsx::Package.new(" +
          ":author => xlsx_author," +
          ":created_at => xlsx_created_at," +
          ":use_shared_strings => xlsx_use_shared_strings" +
          ");" +
        template.source +
        ";xlsx_package.to_stream.string;"
      end

    end
  end
end

ActionView::Template.register_template_handler :axlsx, ActionView::Template::Handlers::AxlsxBuilder
