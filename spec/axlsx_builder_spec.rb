require 'spec_helper'

describe 'Axlsx template handler' do

  AB = ActionView::Template::Handlers::AxlsxBuilder
  VT = Struct.new(:source)

  let( :handler ) { AB.new }

  let( :template ) do
    VT.new("wb = xlsx_package.workbook;\nwb.add_worksheet(name: 'Test') do |sheet|\n\tsheet.add_row ['one', 'two', 'three']\n\tsheet.add_row ['a', 'b', 'c']\nend\n")
  end

  context "Rails #{Rails.version}" do
    # for testing if the author is set
    # before do
      # Rails.stub_chain(:application, :config, :axlsx_author).and_return( 'Elmer Fudd' )
    # end

    it "has xlsx format" do
      if Rails::VERSION::MAJOR >= 6
        expect(handler.default_format).to eq(mime_type.symbol)
      else
        expect(handler.default_format).to eq(mime_type)
      end
    end

    it "compiles to an excel spreadsheet when passing in a source" do
      xlsx_package, wb = nil
      source = "wb = xlsx_package.workbook;\nwb.add_worksheet(name: 'Test') do |sheet|\n\tsheet.add_row ['four', 'five', 'six']\n\tsheet.add_row ['d', 'e', 'f']\nend\n"
      eval( AB.new.call template, source )
      xlsx_package.serialize('/tmp/axlsx_temp.xlsx')
      expect{ wb = Roo::Excelx.new('/tmp/axlsx_temp.xlsx') }.to_not raise_error
      expect(wb.cell(2,3)).to eq('f')
    end

    it "compiles to an excel spreadsheet when inferring source from template " do
      xlsx_package, wb = nil
      eval( AB.new.call template )
      xlsx_package.serialize('/tmp/axlsx_temp.xlsx')
      expect{ wb = Roo::Excelx.new('/tmp/axlsx_temp.xlsx') }.to_not raise_error
      expect(wb.cell(2,3)).to eq('c')
    end

    #TODO:
    # Test if author field is set - does roo parse that?
  end
end
