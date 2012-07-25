require'spec_helper'
describe 'Axlsx renderer' do

  it "is registered" do
    ActionController::Renderers::RENDERERS.include?(:xlsx)
  end

  it "has mime type" do
  	Mime::XLSX.should be
  	Mime::XLSX.to_sym.should == :xlsx
  	Mime::XLSX.to_s.should == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
  end

end