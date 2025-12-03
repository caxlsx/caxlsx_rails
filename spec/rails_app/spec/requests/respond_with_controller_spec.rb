# frozen_string_literal: true

require 'spec_helper'

describe Examples::RespondWithController do
  let(:path) { '/examples/respond_with.xlsx' }

  it 'loads the XLSX template' do
    visit path

    expect(page.response_headers['Content-Type']).to start_with 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    validate_xlsx_file(page.source)
  end
end
