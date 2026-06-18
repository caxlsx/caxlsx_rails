# frozen_string_literal: true

require 'spec_helper'

# Regression test: on Rails >= 8.0, render option normalization runs AFTER
# custom renderers (rails/rails moved it from _normalize_render into
# render_to_body), so the renderer's own template/prefixes defaulting is
# actually exercised. Computing prefixes from `ancestors.take_while` yields []
# when a module is prepended to the controller, so the template was looked up
# at the view-paths root and raised ActionView::MissingTemplate.
describe Examples::PrependedModuleController do
  it 'resolves the template although a module is prepended to the controller' do
    visit '/examples/prepended_module.xlsx'

    expect(page.response_headers['Content-Type']).to start_with 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    validate_xlsx_file(page.source)
  end
end
