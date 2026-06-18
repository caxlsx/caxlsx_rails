# frozen_string_literal: true

require 'spec_helper'

describe Examples::RenderPartialController do
  let(:path) { '/examples/render_partial.xlsx' }

  it 'loads the XLSX template' do
    visit path

    expect(page.response_headers['Content-Type']).to start_with 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    validate_xlsx_file(page.source)
  end
end
