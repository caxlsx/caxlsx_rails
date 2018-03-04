require'spec_helper'

describe 'Axlsx renderer' do

  it "is registered" do
    ActionController::Renderers::RENDERERS.include?(:xlsx)
  end

  it "has mime type" do
    mime = mime_type
  	expect(mime).to be
  	expect(mime.to_sym).to eq(:xlsx)
  	expect(mime.to_s).to eq("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
  end

end