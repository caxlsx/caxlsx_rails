# frozen_string_literal: true

require 'axlsx_rails/template_handler'

module AxlsxRails
  class Railtie < Rails::Railtie
    initializer 'axlsx_rails.initialization' do
      ActiveSupport.on_load(:action_view) do
        ActionView::Template.register_template_handler :axlsx, AxlsxRails::TemplateHandler.new
      end

      ActiveSupport.on_load(:action_controller) do
        require 'axlsx_rails/action_controller'
      end
    end
  end
end
