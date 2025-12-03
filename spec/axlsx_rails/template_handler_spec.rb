# frozen_string_literal: true

require 'spec_helper'

describe AxlsxRails::TemplateHandler do
  describe '#default_format' do
    subject { described_class.new.default_format }

    it 'has xlsx format' do
      is_expected.to eq(Mime[:xlsx].symbol)
    end
  end

  describe '#call' do
    shared_examples_for 'render the template' do
      let(:template_source) { <<~RUBY }
        wb = xlsx_package.workbook

        wb.add_worksheet(name: 'Test') do |sheet|
          sheet.add_row ['one', 'two', 'three']
          sheet.add_row ['a', 'b', 'c']
        end
      RUBY

      it 'compiles to an excel spreadsheet' do
        validate_xlsx_file(eval(subject))
      end

      context 'when the template ends with a comment line' do
        let(:template_string) { <<~RUBY.strip }
          wb = xlsx_package.workbook
          wb.add_worksheet(name: 'Test') do |sheet|
            sheet.add_row ['one', 'two', 'three']
            sheet.add_row ['a', 'b', 'c']
          end
          # Extra comment
        RUBY

        it 'compiles to an excel spreadsheet' do
          validate_xlsx_file(eval(subject))
        end
      end
    end

    context 'when passing in a source' do
      subject { described_class.new.call(double('Template'), template_source) }

      it_behaves_like 'render the template'
    end

    context 'when not passing in a source' do
      subject { described_class.new.call(double('Template', source: template_source)) }

      it_behaves_like 'render the template'
    end
  end
end
