require 'action_controller'
unless defined? Mime::XLSX
	Mime::Type.register "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", :xlsx
end

ActionController::Renderers.add :xlsx do |filename, options|
  options[:template] = filename

  disposition   = options.delete(:disposition) || 'attachment'
  download_name = options.delete(:filename) || "#{filename}.xlsx"
  download_name += ".xlsx" unless download_name =~ /\.xlsx$/

  send_data render_to_string(options), :filename => download_name, :type => Mime::XLSX, :disposition => disposition
end

# For respond_to default
class ActionController::Responder
  def to_xlsx
    controller.render :xlsx => controller.action_name
  end
end
