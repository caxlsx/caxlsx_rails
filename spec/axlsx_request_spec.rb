require 'spec_helper'
describe 'Axlsx request', :type => :request do

  after(:each) do
    if File.exists? '/tmp/axlsx_temp.xlsx'
      File.unlink '/tmp/axlsx_temp.xlsx'
    end
  end

  it "has a working dummy app" do
    @user1 = User.create name: 'Elmer', last_name: 'Fudd', address: '1234 Somewhere, Over NY 11111', email: 'elmer@fudd.com'
    visit '/'
    page.should have_content "Hey, you"
  end

  it "downloads an excel file from default respond_to" do
    visit '/home.xlsx'
    page.response_headers['Content-Type'].should == Mime::XLSX.to_s + "; charset=utf-8"
    File.open('/tmp/axlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Roo::Excelx.new('/tmp/axlsx_temp.xlsx') }.to_not raise_error
    wb.cell(2,1).should == 'Untie!'
  end

  it "downloads an excel file from respond_to while specifying filename" do
    visit '/useheader.xlsx'

    page.response_headers['Content-Type'].should == Mime::XLSX.to_s
    page.response_headers['Content-Disposition'].should include("filename=\"filename_test.xlsx\"")

    File.open('/tmp/axlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Roo::Excelx.new('/tmp/axlsx_temp.xlsx') }.to_not raise_error
    wb.cell(2,1).should == 'Untie!'
  end

  it "downloads an excel file from respond_to while specifying filename in direct format" do
    visit '/useheader.xlsx?set_direct=true'

    page.response_headers['Content-Type'].should == Mime::XLSX.to_s + "; charset=utf-8"
    page.response_headers['Content-Disposition'].should include("filename=\"filename_test.xlsx\"")

    File.open('/tmp/axlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Roo::Excelx.new('/tmp/axlsx_temp.xlsx') }.to_not raise_error
    wb.cell(2,1).should == 'Untie!'
  end

  it "downloads an excel file from render statement with filename" do
    visit '/another.xlsx'

    page.response_headers['Content-Type'].should == Mime::XLSX
    page.response_headers['Content-Disposition'].should include("filename=\"filename_test.xlsx\"")

    File.open('/tmp/axlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Roo::Excelx.new('/tmp/axlsx_temp.xlsx') }.to_not raise_error
    wb.cell(2,1).should == 'Untie!'
  end

  it "downloads an excel file from acts_as_xlsx model" do
    User.destroy_all
    @user1 = User.create name: 'Elmer', last_name: 'Fudd', address: '1234 Somewhere, Over NY 11111', email: 'elmer@fudd.com'
    @user2 = User.create name: 'Bugs', last_name: 'Bunny', address: '1234 Left Turn, Albuquerque NM 22222', email: 'bugs@bunny.com'
    visit '/users.xlsx'
    page.response_headers['Content-Type'].should == Mime::XLSX.to_s + "; charset=utf-8"
    File.open('/tmp/axlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Roo::Excelx.new('/tmp/axlsx_temp.xlsx') }.to_not raise_error
    wb.cell(3,2).should == 'Bugs'
  end

  it "downloads an excel file with partial" do
    visit '/withpartial.xlsx'
    page.response_headers['Content-Type'].should == Mime::XLSX.to_s + "; charset=utf-8"
    File.open('/tmp/axlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Roo::Excelx.new('/tmp/axlsx_temp.xlsx') }.to_not raise_error
    wb.cell(1,1,wb.sheets[0]).should == 'Cover'
    wb.cell(2,1,wb.sheets[1]).should == "Untie!"
  end

  it "handles nested resources" do
    User.destroy_all
    @user = User.create name: 'Bugs', last_name: 'Bunny', address: '1234 Left Turn, Albuquerque NM 22222', email: 'bugs@bunny.com'
    @user.likes.create(:name => 'Carrots')
    @user.likes.create(:name => 'Celery')
    visit "/users/#{@user.id}/likes.xlsx"
    page.response_headers['Content-Type'].should == Mime::XLSX.to_s + "; charset=utf-8"
    File.open('/tmp/axlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Roo::Excelx.new('/tmp/axlsx_temp.xlsx') }.to_not raise_error
    wb.cell(1,1).should == 'Bugs'
    wb.cell(2,1).should == 'Carrots'
    wb.cell(3,1).should == 'Celery'
  end

  it "handles reference to absolute paths" do
    User.destroy_all
    @user = User.create name: 'Bugs', last_name: 'Bunny', address: '1234 Left Turn, Albuquerque NM 22222', email: 'bugs@bunny.com'
    visit "/users/#{@user.id}/render_elsewhere.xlsx"
    page.response_headers['Content-Type'].should == Mime::XLSX.to_s
    [[1,false],[2,false],[3,true],[4,true],[5,false]].reverse.each do |s|
      visit "/home/render_elsewhere.xlsx?type=#{s[0]}"
      page.response_headers['Content-Type'].should == Mime::XLSX.to_s +
        (s[1] ? "; charset=utf-8" : '')
      File.open('/tmp/axlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
      wb = nil
      expect{ wb = Roo::Excelx.new('/tmp/axlsx_temp.xlsx') }.to_not raise_error
      if s[0] == 5
        wb.cell(1,1).should == 'Bad'
      else
        wb.cell(2,2).should == 'Bugs'
      end
    end
  end

  it "uses respond_with" do
    User.destroy_all
    @user = User.create name: 'Responder', last_name: 'Bunny', address: '1234 Right Turn, Albuquerque NM 22222', email: 'bugs@bunny.com'
    expect {
      visit "/users/#{@user.id}.xlsx"
    }.to_not raise_error
    File.open('/tmp/axlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Roo::Excelx.new('/tmp/axlsx_temp.xlsx') }.to_not raise_error
    wb.cell(2,1).should == 'Untie!'
  end

  unless Rails.version < '3.2'
    it "handles missing format with render :xlsx" do
      visit '/another'

      page.response_headers['Content-Type'].should == Mime::XLSX
      page.response_headers['Content-Disposition'].should include("filename=\"filename_test.xlsx\"")

      File.open('/tmp/axlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
      wb = nil
      expect{ wb = Roo::Excelx.new('/tmp/axlsx_temp.xlsx') }.to_not raise_error
      wb.cell(2,1).should == 'Untie!'
    end
  end
end
