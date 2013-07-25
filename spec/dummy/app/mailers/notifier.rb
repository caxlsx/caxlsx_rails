class Notifier < ActionMailer::Base
    default :from => 'noreply@company.com'

    def instructions(user)
      @user = user
      xlsx = render_to_string handlers: [:axlsx], template: 'users/mailers/instructions', layout: false
      attachments["user_#{user.id}.pdf"] = {mime_type: Mime::XLSX, content: xlsx}
      mail :to => user.email, :subject => 'Instructions'
    end
end
