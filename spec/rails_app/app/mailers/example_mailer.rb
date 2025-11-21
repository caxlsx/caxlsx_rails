class ExampleMailer < ActionMailer::Base
  default from: 'noreply@example.com'

  def send_attachment(headers, values)
    @headers = headers
    @values = values

    xlsx_content = render_to_string(
      handlers: [:axlsx],
      template: 'example_mailer/attachment',
      layout: false,
      formats: [:xlsx]
    )

    if Rails.gem_version < Gem::Version.new('5.0')
      attachments['attachment.xlsx'] = {
        mime_type: Mime::XLSX,
        content: xlsx_content
      }
    else
      attachments['attachment.xlsx'] = {
        mime_type: Mime[:xlsx],
        content: xlsx_content
      }
    end

    mail to: 'receiver@example.com', subject: 'Important details'
  end

end
