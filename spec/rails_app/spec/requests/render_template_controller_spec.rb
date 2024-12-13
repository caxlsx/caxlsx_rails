# frozen_string_literal: true

require 'spec_helper'

describe Examples::RenderTemplateController do
  let(:path) { "/examples/render_template/#{variant}.xlsx" }

  shared_examples_for 'responds properly' do
    it 'works' do
      visit path

      expect(page.response_headers['Content-Type']).to start_with 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'

      validate_xlsx_file(page.source)
    end
  end

  context 'when using both xlsx and template, but with different values' do
    let(:variant) { 1 }

    it_behaves_like 'responds properly'
  end

  context 'when using both xlsx and template with the same values' do
    let(:variant) { 2 }

    it_behaves_like 'responds properly'
  end

  context 'when using only template' do
    let(:variant) { 3 }

    it_behaves_like 'responds properly'
  end

  context 'when using direct render template' do
    let(:variant) { 4 }

    it_behaves_like 'responds properly'
  end

  context 'when using only xlsx' do
    let(:variant) { 5 }

    it_behaves_like 'responds properly'
  end
end
