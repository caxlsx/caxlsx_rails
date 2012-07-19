require 'action_view'
module ActionView
  module Template::Handlers
    class AxlsxBuilder
      def default_format
        Mime::XLSX
      end

      def self.call(template)
        "xlsx_package = Axlsx::Package.new(:author => #{axlsx_author.inspect});\n" +
          template.source +
          ";\nxlsx_package.to_stream.string;"
      end

      private

      def self.axlsx_author
        Rails.application.config.respond_to?(:axlsx_author) ? Rails.application.config.axlsx_author : nil
      end
    end
  end
end

ActionView::Template.register_template_handler :axlsx, ActionView::Template::Handlers::AxlsxBuilder
