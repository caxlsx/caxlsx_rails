require 'action_controller'
Mime::Type.register "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", :xlsx

ActionController::Renderers.add :xlsx do |filename, options|
	disposition   = options.delete(:disposition) || 'attachment'
	download_name = options.delete(:filename) || "#{filename}.xlsx"
	download_name += ".xlsx" unless download_name =~ /\.xlsx$/
	send_data render_to_string(filename, options), :filename => download_name, :type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", :disposition => disposition
end

# For respond_to default
class ActionController::Responder
	def to_xlsx
		controller.render :xlsx => controller.action_name
	end
end