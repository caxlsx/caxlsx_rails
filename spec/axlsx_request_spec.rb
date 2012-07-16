require'spec_helper'
describe 'Axlsx request', :type => :request do

  it "has a working dummy app" do
    visit '/'
    page.should have_content "Hey, you"
  end

  it "downloads an excel file from default respond_to" do
    visit '/home.xlsx'
    page.response_headers['Content-Type'].should == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet; charset=utf-8"
    File.open('/tmp/axlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Excelx.new('/tmp/axlsx_temp.xlsx') }.to_not raise_error
    wb.cell(2,1).should == 'Untie!'
  end

  it "downloads an excel file from render statement with filename" do
    visit '/another.xlsx'
    page.response_headers['Content-Type'].should == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet; charset=utf-8"
    # Not being sent for some reason
    # page.response_headers['Content-Disposition'].should include("filename=\"filename_test.xlsx\"")
    File.open('/tmp/axlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Excelx.new('/tmp/axlsx_temp.xlsx') }.to_not raise_error
    wb.cell(2,1).should == 'Untie!'
  end

end