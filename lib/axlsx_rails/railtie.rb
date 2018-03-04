# frozen_string_literal: true

module AxlsxRails
  class Railtie < Rails::Railtie
    initializer 'axlsx_rails.initialization' do
      ActiveSupport.on_load(:active_view) do
        require 'axlsx_rails/template_handler'
      end

      ActiveSupport.on_load(:action_controller) do
        require 'axlsx_rails/action_controller'
      end
    end
  end
end
