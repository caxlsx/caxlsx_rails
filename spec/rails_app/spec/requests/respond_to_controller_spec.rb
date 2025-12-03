# frozen_string_literal: true

require 'spec_helper'

describe Examples::RespondToController do
  let(:path) { ['/examples/respond_to', format].compact.join('.') }

  context 'when format is missing' do
    let(:format) { nil }

    it 'loads the HTML template' do
      visit path

      expect(page.response_headers['Content-Type']).to start_with 'text/html'
      expect(page.body).to include('This is the default HTML response')
    end
  end

  context 'when the format is html' do
    let(:format) { 'html' }

    it 'loads the HTML template' do
      visit path

      expect(page.response_headers['Content-Type']).to start_with 'text/html'
      expect(page.body).to include('This is the default HTML response')
    end
  end

  context 'when the format is xlsx' do
    let(:format) { 'xlsx' }

    it 'loads the XLSX template' do
      visit path

      expect(page.response_headers['Content-Type']).to start_with 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      validate_xlsx_file(page.source)
    end
  end
end
