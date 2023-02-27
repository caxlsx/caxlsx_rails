require 'spec_helper'

describe AxlsxRails::TemplateHandler do
  subject(:handler) { described_class.new }

  describe '#default_format' do
    it "has xlsx format" do
      if Rails::VERSION::MAJOR >= 6
        expect(handler.default_format).to eq(Mime[:xlsx].symbol)
      elsif Rails::VERSION::MAJOR >= 5
        expect(handler.default_format).to eq(Mime[:xlsx])
      else
        expect(handler.default_format).to eq(Mime::XLSX)
      end
    end
  end

  describe 'how to compile it to an excel spreadsheet' do
    let(:template) { Struct.new(:source).new(template_string) }

    let(:template_string) { <<~RUBY }
      wb = xlsx_package.workbook
      wb.add_worksheet(name: 'Test') do |sheet|
        sheet.add_row ['one', 'two', 'three']
        sheet.add_row ['a', 'b', 'c']
      end
    RUBY

    context 'when passing in a source' do
      let(:source_string) { <<~RUBY }
        wb = xlsx_package.workbook
        wb.add_worksheet(name: 'Test') do |sheet|
          sheet.add_row ['four', 'five', 'six']
          sheet.add_row ['d', 'e', 'f']
        end
      RUBY

      it "compiles to an excel spreadsheet when passing in a source" do
        wb = nil

        file = Tempfile.new(['caxlsx', '.xlsx'])
        file.binmode
        file.write(eval(described_class.new.call(template, source_string)))
        file.close

        expect { wb = Roo::Excelx.new(file.path) }.to_not raise_error
        expect(wb.cell(2,3)).to eq('f')
      end
    end

    context 'when not passing in a source' do
      it "compiles to an excel spreadsheet when inferring source from template" do
        wb = nil

        file = Tempfile.new(['caxlsx', '.xlsx'])
        file.binmode
        file.write(eval(described_class.new.call(template)))
        file.close

        expect { wb = Roo::Excelx.new(file.path) }.to_not raise_error
        expect(wb.cell(2,3)).to eq('c')
      end

      context 'when template ends with a comment line' do
        let(:template_string) { <<~RUBY.strip }
          wb = xlsx_package.workbook
          wb.add_worksheet(name: 'Test') do |sheet|
            sheet.add_row ['one', 'two', 'three']
            sheet.add_row ['a', 'b', 'c']
          end
          # Extra comment
        RUBY

        it "compiles to an excel spreadsheet when inferring source from template" do
          wb = nil

          file = Tempfile.new(['caxlsx', '.xlsx'])
          file.binmode
          file.write(eval(described_class.new.call(template)))
          file.close

          expect { wb = Roo::Excelx.new(file.path) }.to_not raise_error
          expect(wb.cell(2,3)).to eq('c')
        end
      end
    end
  end
end
