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
    options[:prefixes] ||= self.class.ancestors
                               .take_while { |a| a.respond_to?(:controller_path) }
                               .map(&:controller_path)
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
