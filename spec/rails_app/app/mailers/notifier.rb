class Notifier < ActionMailer::Base
  default :from => 'noreply@company.com'

  def instructions(user)
    @user = user

    # normal syntax
    xlsx = render_to_string handlers: [:axlsx], template: 'users/send_instructions', layout: false, formats: [:xlsx]
    if Rails.gem_version < Gem::Version.new("5.0")
      attachments["user_#{user.id}.xlsx"] = {mime_type: Mime::XLSX, content: xlsx}
    else
      attachments["user_#{user.id}.xlsx"] = {mime_type: Mime[:xlsx], content: xlsx}
    end

      mail :to => user.email, :subject => 'Instructions'
  end

end