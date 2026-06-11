# frozen_string_literal: true

require 'action_controller'

Mime::Type.register 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', :xlsx unless Mime[:xlsx]

ActionController::Renderers.add :xlsx do |filename, options|
  #
  # You can always specify a template:
  #
  #  def called_action
  #    render xlsx: 'filename', template: 'controller/diff_action'
  #  end
  #
  # And the normal use case works:
  #
  #  def called_action
  #    render 'diff_action'
  #    # or
  #    render 'controller/diff_action'
  #  end
  #
  if options[:template].nil?
    options[:template] ||= action_name
    # Use the controller's _prefixes (built from the superclass chain) instead of
    # deriving prefixes from `ancestors`: a module prepended to the controller
    # (memo_wise, instrumentation gems, ...) is the first ancestor and stops a
    # take_while immediately, yielding no prefixes at all. Up to Rails 7.2 this
    # branch was dead code because render option normalization ran before custom
    # renderers and had already defaulted :template and :prefixes; Rails 8.0
    # moved that normalization after the renderer, exposing the bug.
    options[:prefixes] ||= _prefixes
  end

  options[:template] = filename.gsub(%r{^.*/}, '') if options[:template] == action_name

  # force layout false
  options[:layout] = false

  # disposition / filename
  disposition = options.delete(:disposition) || 'attachment'
  file_name = options.delete(:filename) || "#{filename.gsub(%r{^.*/}, '')}.xlsx"
  file_name = "#{file_name}.xlsx" unless file_name =~ /\.xlsx$/

  # alternate settings
  options[:locals] ||= {}
  options[:locals][:xlsx_author] ||= options.delete(:xlsx_author)
  options[:locals][:xlsx_created_at] ||= options.delete(:xlsx_created_at)
  unless options[:locals][:xlsx_use_shared_strings]
    options[:locals][:xlsx_use_shared_strings] = options.delete(:xlsx_use_shared_strings)
  end

  send_data render_to_string(options), filename: file_name, type: Mime[:xlsx], disposition: disposition
end

# For respond_to default
if defined?(ActionController::Responder)
  class ActionController::Responder
    def to_xlsx
      @_action_has_layout = false
      if @default_response
        @default_response.call(options)
      else
        controller.render({ xlsx: controller.action_name }.merge(options))
      end
    end
  end
end
