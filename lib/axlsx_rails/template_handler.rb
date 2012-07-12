require 'action_view'
module ActionView
  module Template::Handlers
    class AxlsxBuilder
      def default_format
        Mime::XLSX
      end
      
      def self.call(template)
        "axlsx_package = Axlsx::Package.new;\n" + 
          template.source +
          ";\naxlsx_package.to_stream.string;"
      end
    end
  end
end

ActionView::Template.register_template_handler :axlsx, ActionView::Template::Handlers::AxlsxBuilder