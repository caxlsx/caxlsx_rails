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

    page.response_headers['Content-Type'].should == Mime::XLSX
    page.response_headers['Content-Disposition'].should include("filename=\"filename_test.xlsx\"")

    File.open('/tmp/axlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Excelx.new('/tmp/axlsx_temp.xlsx') }.to_not raise_error
    wb.cell(2,1).should == 'Untie!'
  end

  it "downloads an excel file from acts_as_xlsx model" do
    @user1 = User.create name: 'Elmer', last_name: 'Fudd', address: '1234 Somewhere, Over NY 11111', email: 'elmer@fudd.com'
    @user2 = User.create name: 'Bugs', last_name: 'Bunny', address: '1234 Left Turn, Albuquerque NM 22222', email: 'bugs@bunny.com'
    visit '/users.xlsx'
    page.response_headers['Content-Type'].should == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet; charset=utf-8"
    File.open('/tmp/axlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Excelx.new('/tmp/axlsx_temp.xlsx') }.to_not raise_error
    wb.cell(3,2).should == 'Bugs'
  end

  it "downloads an excel file with partial" do
    visit '/withpartial.xlsx'
    page.response_headers['Content-Type'].should == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet; charset=utf-8"
    File.open('/tmp/axlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Excelx.new('/tmp/axlsx_temp.xlsx') }.to_not raise_error
    wb.cell(1,1,wb.sheets[0]).should == 'Cover'
    wb.cell(2,1,wb.sheets[1]).should == "Untie!"
  end

end
