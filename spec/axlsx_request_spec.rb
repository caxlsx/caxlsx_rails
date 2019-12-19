require 'spec_helper'
describe 'Caxlsx request', :type => :request do

  after(:each) do
    if File.exists? '/tmp/caxlsx_temp.xlsx'
      File.unlink '/tmp/caxlsx_temp.xlsx'
    end
  end

  it "has a working dummy app" do
    User.create name: 'Elmer', last_name: 'Fudd', address: '1234 Somewhere, Over NY 11111', email: 'elmer@fudd.com'
    visit '/'
    expect(page).to have_content("Hey, you")
  end

  it "downloads an excel file from default respond_to" do
    visit '/home.xlsx'
    expect(page.response_headers['Content-Type']).to eq(mime_type.to_s + "; charset=utf-8")
    File.open('/tmp/caxlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Roo::Excelx.new('/tmp/caxlsx_temp.xlsx') }.to_not raise_error
    expect(wb.cell(2,1)).to eq('Untie!')
  end

  it "downloads an excel file from respond_to while specifying filename" do
    visit '/useheader.xlsx'

    expect(page.response_headers['Content-Type']).to eq(mime_type.to_s)
    expect(page.response_headers['Content-Disposition']).to include("filename=\"filename_test.xlsx\"")

    File.open('/tmp/caxlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Roo::Excelx.new('/tmp/caxlsx_temp.xlsx') }.to_not raise_error
    expect(wb.cell(2,1)).to eq('Untie!')
  end

  it "downloads an excel file from respond_to while specifying filename in direct format" do
    visit '/useheader.xlsx?set_direct=true'

    expect(page.response_headers['Content-Type']).to eq(mime_type.to_s + "; charset=utf-8")
    expect(page.response_headers['Content-Disposition']).to include("filename=\"filename_test.xlsx\"")

    File.open('/tmp/caxlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Roo::Excelx.new('/tmp/caxlsx_temp.xlsx') }.to_not raise_error
    expect(wb.cell(2,1)).to eq('Untie!')
  end

  it "downloads an excel file from render statement with filename" do
    visit '/another.xlsx'

    expect(page.response_headers['Content-Type']).to eq(mime_type)
    expect(page.response_headers['Content-Disposition']).to include("filename=\"filename_test.xlsx\"")

    File.open('/tmp/caxlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Roo::Excelx.new('/tmp/caxlsx_temp.xlsx') }.to_not raise_error
    expect(wb.cell(2,1)).to eq('Untie!')
  end

  it "downloads an excel file from acts_as_xlsx model" do
    User.destroy_all
    User.create name: 'Elmer', last_name: 'Fudd', address: '1234 Somewhere, Over NY 11111', email: 'elmer@fudd.com'
    User.create name: 'Bugs', last_name: 'Bunny', address: '1234 Left Turn, Albuquerque NM 22222', email: 'bugs@bunny.com'
    visit '/users.xlsx'
    expect(page.response_headers['Content-Type']).to eq(mime_type.to_s + "; charset=utf-8")
    File.open('/tmp/caxlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Roo::Excelx.new('/tmp/caxlsx_temp.xlsx') }.to_not raise_error
    expect(wb.cell(3,2)).to eq('Bugs')
  end

  it "downloads an excel file with partial" do
    visit '/withpartial.xlsx'
    expect(page.response_headers['Content-Type']).to eq(mime_type.to_s + "; charset=utf-8")
    File.open('/tmp/caxlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Roo::Excelx.new('/tmp/caxlsx_temp.xlsx') }.to_not raise_error
    expect(wb.cell(1,1,wb.sheets[0])).to eq('Cover')
    expect(wb.cell(2,1,wb.sheets[1])).to eq("Untie!")
  end

  it "handles nested resources" do
    User.destroy_all
    @user = User.create name: 'Bugs', last_name: 'Bunny', address: '1234 Left Turn, Albuquerque NM 22222', email: 'bugs@bunny.com'
    @user.likes.create(:name => 'Carrots')
    @user.likes.create(:name => 'Celery')
    visit "/users/#{@user.id}/likes.xlsx"
    expect(page.response_headers['Content-Type']).to eq(mime_type.to_s + "; charset=utf-8")
    File.open('/tmp/caxlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Roo::Excelx.new('/tmp/caxlsx_temp.xlsx') }.to_not raise_error
    expect(wb.cell(1,1)).to eq('Bugs')
    expect(wb.cell(2,1)).to eq('Carrots')
    expect(wb.cell(3,1)).to eq('Celery')
  end

  it "handles reference to absolute paths" do
    User.destroy_all
    @user = User.create name: 'Bugs', last_name: 'Bunny', address: '1234 Left Turn, Albuquerque NM 22222', email: 'bugs@bunny.com'
    visit "/users/#{@user.id}/render_elsewhere.xlsx"
    expect(page.response_headers['Content-Type']).to eq(mime_type.to_s)
    [[1,false],[3,true],[4,true],[5,false]].reverse.each do |s|
      visit "/home/render_elsewhere.xlsx?type=#{s[0]}"
      expect(page.response_headers['Content-Type']).to eq(mime_type.to_s + (s[1] ? "; charset=utf-8" : ''))
      File.open('/tmp/caxlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
      wb = nil
      expect{ wb = Roo::Excelx.new('/tmp/caxlsx_temp.xlsx') }.to_not raise_error
      if s[0] == 5
        expect(wb.cell(1,1)).to eq('Bad')
      else
        expect(wb.cell(2,2)).to eq('Bugs')
      end
    end
  end

  it "uses respond_with" do
    User.destroy_all
    @user = User.create name: 'Responder', last_name: 'Bunny', address: '1234 Right Turn, Albuquerque NM 22222', email: 'bugs@bunny.com'
    visit "/users/#{@user.id}.xlsx"
    expect {
      visit "/users/#{@user.id}.xlsx"
    }.to_not raise_error
    File.open('/tmp/caxlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Roo::Excelx.new('/tmp/caxlsx_temp.xlsx') }.to_not raise_error
    expect(wb.cell(2,1)).to eq('Untie!')
  end

  it "ignores layout" do
    User.destroy_all
    @user = User.create name: 'Responder', last_name: 'Bunny', address: '1234 Right Turn, Albuquerque NM 22222', email: 'bugs@bunny.com'
    expect {
      visit "/users/export/#{@user.id}.xlsx"
    }.to_not raise_error
    File.open('/tmp/caxlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
    wb = nil
    expect{ wb = Roo::Excelx.new('/tmp/caxlsx_temp.xlsx') }.to_not raise_error
    expect(wb.cell(2,1)).to eq('Untie!')
  end

  unless Rails.version < '3.2'
    it "handles missing format with render :xlsx" do
      visit '/another'

      expect(page.response_headers['Content-Type']).to eq(mime_type)
      expect(page.response_headers['Content-Disposition']).to include("filename=\"filename_test.xlsx\"")

      File.open('/tmp/caxlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
      wb = nil
      # wb = Roo::Excelx.new('/tmp/caxlsx_temp.xlsx')
      expect{ wb = Roo::Excelx.new('/tmp/caxlsx_temp.xlsx') }.to raise_error(Zip::ZipError)
      # wb.cell(2,1).should == 'Untie!'
    end
  end

  unless Rails.version < '4.0'
    Capybara.register_driver :mime_all do |app|
      Capybara::RackTest::Driver.new(app, headers: { 'HTTP_ACCEPT' => '*/*' })
    end

    def puts_def_formats(title)
      puts "default formats #{title.ljust(30)}: #{ActionView::Base.default_formats}"
    end

    it "mime all with render :xlsx and then :html" do
      # puts_def_formats 'before'
      ActionView::Base.default_formats.delete :xlsx # see notes
      # puts_def_formats 'in my project'
      Capybara.current_driver = :mime_all
      visit '/another'
      # puts_def_formats 'after render xlsx with */*'
      expect{
        visit '/home/only_html'
      }.to_not raise_error
      ActionView::Base.default_formats.push :xlsx # see notes

      # Output:
      # default formats before                        : [:html, :text, :js, :css, :ics, :csv, :vcf, :png, :jpeg, :gif, :bmp, :tiff, :mpeg, :xml, :rss, :atom, :yaml, :multipart_form, :url_encoded_form, :json, :pdf, :zip, :xlsx]
      # default formats in my project                 : [:html, :text, :js, :css, :ics, :csv, :vcf, :png, :jpeg, :gif, :bmp, :tiff, :mpeg, :xml, :rss, :atom, :yaml, :multipart_form, :url_encoded_form, :json, :pdf, :zip]
      # default formats after render xlsx with */*    : [:xlsx, :text, :js, :css, :ics, :csv, :vcf, :png, :jpeg, :gif, :bmp, :tiff, :mpeg, :xml, :rss, :atom, :yaml, :multipart_form, :url_encoded_form, :json, :pdf, :zip]

      # Failure/Error: visit '/home/only_html'
      # ActionView::MissingTemplate:
      #   Missing template home/only_html, application/only_html with {:locale=>[:en], :formats=>[:xlsx, :text, :js, :css, :ics, :csv, :vcf, :png, :jpeg, :gif, :bmp, :tiff, :mpeg, :xml, :rss, :atom, :yaml, :multipart_form, :url_encoded_form, :json, :pdf, :zip], :variants=>[], :handlers=>[:erb, :builder, :raw, :ruby, :axlsx]}.
    end
  end

  if Rails::VERSION::MAJOR < 6
    it "downloads an excel file when there is no action" do
      User.destroy_all
      User.create name: 'Elmer', last_name: 'Fudd', address: '1234 Somewhere, Over NY 11111', email: 'elmer@fudd.com'
      User.create name: 'Bugs', last_name: 'Bunny', address: '1234 Left Turn, Albuquerque NM 22222', email: 'bugs@bunny.com'
      visit '/users/noaction.xlsx'
      expect(page.response_headers['Content-Type']).to eq(mime_type.to_s + "; charset=utf-8")
      File.open('/tmp/caxlsx_temp.xlsx', 'w') {|f| f.write(page.source) }
      wb = nil
      expect{ wb = Roo::Excelx.new('/tmp/caxlsx_temp.xlsx') }.to_not raise_error
      expect(wb.cell(3,2)).to eq('Bugs')
    end
  end
end
