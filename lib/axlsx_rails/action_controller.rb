require 'action_controller'
Mime::Type.register "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", :xlsx

ActionController::Renderers.add :xlsx do |filename, options|
	disposition = options.delete(:disposition) || 'attachment'
	send_data render_to_string(options), :filename => "#{filename}.xlsx", :type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", :disposition => disposition
end