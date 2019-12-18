# frozen_string_literal: true

warn "DEPRECATION WARNING: axlsx_rails has been renamed to caxlsx_rails. See http://github.com/caxlsx"

require 'axlsx_rails/railtie' if defined?(Rails)
