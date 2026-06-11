# frozen_string_literal: true

module Examples
  class PrependedModuleController < ApplicationController
    # Gems like memo_wise or instrumentation libraries prepend modules into
    # controllers. A prepended module becomes the first entry in `ancestors`
    # and does not respond to `controller_path`, so a prefix computation based
    # on `ancestors.take_while { |a| a.respond_to?(:controller_path) }`
    # returns an empty array for this controller.
    module Prepended; end
    prepend Prepended

    def show
      render xlsx: 'show'
    end
  end
end
