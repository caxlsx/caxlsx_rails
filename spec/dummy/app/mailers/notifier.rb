class Notifier < ActionMailer::Base
  default :from => 'noreply@company.com'
  # default :from => "Didier Leser - CESAM Nature <didier.leser@cesam-nature.com>"

  def instructions(user)
    @user = user

    # normal syntax
    xlsx = render handlers: [:axlsx], template: 'users/mailers/instructions', layout: false

    # using render_to_string. sometimes not available, but why??
    # xlsx = render_to_string handlers: [:axlsx], template: 'users/mailers/instructions', layout: false

    # creating own view
    # av = ActionView::Base.new()
    # av.view_paths = ActionController::Base.view_paths
    # av.extend ApplicationHelper
    # av.assign user: @user
    # xlsx = av.render handlers: [:axlsx], template: "users/mailers/instructions"
    
    attachments["user_#{user.id}.pdf"] = {mime_type: Mime::XLSX, content: xlsx}
    mail :to => user.email, :subject => 'Instructions'
  end


end