require 'spec_helper'

describe "Mailer", type: :request do
  before :each do
    @user = User.create name: 'Elmer', last_name: 'Fudd', address: '1234 Somewhere, Over NY 11111', email: 'elmer@fudd.com'
  end

  it "attaches an xlsx file" do
    visit "/users/#{@user.id}/send_instructions"
    last_email = ActionMailer::Base.deliveries.last
    expect(last_email.to).to eq([@user.email])
    expect(last_email.attachments.first).to be
    expect(last_email.attachments.first.content_type).to match(/#{mime_type}/)
  end
end
