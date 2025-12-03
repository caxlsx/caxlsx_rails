# frozen_string_literal: true

require 'spec_helper'

describe Examples::FileNameController do
  let(:path) { '/examples/file_name.xlsx' }

  it 'downloads the XLSX file with the new name' do
    visit path

    expect(page.response_headers['Content-Type']).to start_with 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    expect(page.response_headers['Content-Disposition']).to include('filename="new_file_name.xlsx"')
    validate_xlsx_file(page.source)
  end

  context 'when explicitly setting the content disposition' do
    it 'downloads the XLSX file with the new name' do
      visit "#{path}?set_content_disposition=true"

      expect(page.response_headers['Content-Type']).to start_with 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      expect(page.response_headers['Content-Disposition']).to include('filename="new_file_name.xlsx"')
      validate_xlsx_file(page.source)
    end
  end
end
